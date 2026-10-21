---
name: nixification
description: "Resolves a missing tool, binary, library, or dependency with Nix flakes or an ephemeral shell. Use on command not found, missing-package errors, or a request to create a flake.nix or reproducible environment. Not for NixOS system or home-manager configuration, nor for errors whose cause is not an absent tool."
---

# Nixification

Resolve missing tools and dependencies using Nix, favoring flakes for reproducibility.

## Core Principle

When a dependency is missing, don't just run an ad-hoc `nix shell` one-liner and move on. Prefer creating (or extending) a `flake.nix` so the environment is reproducible. Fall back to ephemeral `nix shell` only for one-off, throwaway commands. Tie-break: one tool used once means ephemeral. A tool reused, or two or more tools, means a flake.

## Decision Flow

1. **Check if a `flake.nix` already exists** in the project root (or the working directory).
   - If yes → read it, add the missing package to `buildInputs` (or create a `devShells` output from the template when none exists), and enter the environment with `nix develop`.
   - If no → decide whether to create one (see below).

2. **Create a `flake.nix` when:**
   - The task involves more than one dependency, or one tool that will be reused.
   - The user is working inside a project directory that will persist.
   - The user explicitly asks for a flake.

3. **Use ephemeral `nix shell` when:**
   - A single binary is needed once, for a one-off command (e.g., `nix shell nixpkgs#jq --command jq '.name' file.json`).
   - The user explicitly asks for a quick/throwaway approach.

## Finding Packages

Apply **principle-use-before-build** before adding a
package. Check the current environment and project dependencies first. Before
assuming a package name, search for it:

```bash
nix search nixpkgs <query> --json 2>/dev/null | head -80
```

If `nix search` is slow or unavailable, fall back to:

```bash
nix eval --impure --json --expr 'builtins.attrNames (builtins.getFlake "nixpkgs").legacyPackages.${builtins.currentSystem}' | tr ',' '\n' | grep -i <query>
```

Package names in nixpkgs often differ from the binary name — e.g., the `rg` binary is `ripgrep`, `fd` is `fd`, `python3` may be `python3Full` or `python312`.

## Ephemeral Shell (one-off)

Run a single command without persisting anything:

```bash
nix shell nixpkgs#<package> --command <binary> [args...]
```

**Example:** `nix shell nixpkgs#jq --command jq '.version' package.json`

To enter an interactive shell with multiple packages:

```bash
nix shell nixpkgs#jq nixpkgs#ripgrep
```

## Creating a flake.nix

When creating a new flake, use this minimal template:

```nix
{
  description = "<short project description>";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Add packages here
          ];
        };
      });
    };
}
```

The template needs only `nixpkgs`, so it adds no `flake-utils` input. After writing `flake.nix`, run in this order. Nix flakes read only git-tracked files, so stage each new file before the next command:

```bash
git add flake.nix      # only in a git repo
nix flake lock
git add flake.lock     # only in a git repo
nix develop
```

Done when the missing binary resolves inside `nix develop` (`command -v <binary>`).

## Extending an Existing flake.nix

Read the current file, locate the `buildInputs` list, and append the missing package. Do not rewrite unrelated parts of the flake. After editing, run `nix flake lock` only after adding an input; otherwise just re-enter with `nix develop`.

## Handling `experimental-features`

Flakes may require opt-in. If an error about experimental features appears, rerun the command with `--extra-experimental-features 'nix-command flakes'`.

## Troubleshooting

Decide and proceed. Ask only before a one-way door, such as changing the pinned nixpkgs of a shared flake.

- Package not found: search again with a broader query, check the binary-to-package name map above, then fall back to the `nix eval --impure` listing.
- `has an unfree license` error: rerun with `NIXPKGS_ALLOW_UNFREE=1` and `--impure`, and report that the package is unfree.
- `not supported on this system` error: look for an alternative package, else tell the human that no build exists for this platform.
- Download or cache failure: retry once, then report the unreachable host and the command to rerun.
