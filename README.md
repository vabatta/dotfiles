# dotfiles

My macOS setup. Homebrew installs the software. GNU Stow links the
configuration files. A few shell scripts set the macOS options. Nix is
installed by hand. It is only for project dev shells.

## Layout

| Path | Contents |
|---|---|
| `darwin/` | Brewfile, macOS defaults, local taps, and the `theme-monitor` source. Every host uses them. |
| `home/` | One stow package for each tool, laid out like $HOME. A package holds everything for its tool: configuration, commands, aliases, and functions. |
| `hosts/` | A Brewfile and a `home/` overlay for each host (git identity, SSH agent). |
| `ai/` | Skills, agents, and rules for Claude Code and OpenCode. |
| `install.sh` | Apply everything. |
| `doctor.sh` | Show where this Mac differs from the repository. |

## How it works

Each tool has one stow package in `home/<tool>/`. The paths inside the
package are the same as the paths in $HOME. Stow makes one symlink for each
file. The installer uses `--no-folding`. As a result, a tool cannot write its
runtime files into the repository.

A package holds everything for its tool:

| Path in the package | Use |
|---|---|
| `.config/<tool>/` | The configuration of the tool. |
| `.local/bin/` | Commands. This directory is on PATH. |
| `.config/zsh/env.d/<tool>.zsh` | Variables and PATH entries. Every shell loads them. |
| `.config/zsh/conf.d/<nn>-<tool>.zsh` | Aliases and shell setup. Interactive shells load them in number order. |
| `.config/zsh/functions/<name>.zsh` | Functions. Interactive shells load them. |
| `.config/theme/handlers.d/<tool>.sh` | The theme handler of the tool. The `theme` command runs it. |

Stow cannot replace a file for one host. Host differences use include files:

- A shared file includes a local file. Example: `git/config` includes `config.local`.
- `hosts/<host>/home/` adds the files that only this host has.
- The installer stows `hosts/<host>/home/` after the shared packages.

The `claude`, `opencode`, and `agents` packages contain symlinks into `ai/`.
Edit the skills and the agents in `ai/`.

## Install

1. Install Nix: https://docs.determinate.systems/
2. Install Homebrew: https://brew.sh
3. Clone the repository and run the installer:

        git clone <repo> ~/dotfiles
        cd ~/dotfiles
        ./install.sh --macos

4. Open 1Password and sign in. In Settings > Developer, turn on `Use the SSH agent` and `Integrate with 1Password CLI`.
5. Run `./doctor.sh` to find problems.

### Options

The command is `install.sh [--adopt] [--macos] [host]`.

| Option | Effect |
|---|---|
| `host` | The host name. The default is the name of this Mac (`mbp` or `mbp-unique`). |
| `--macos` | Also apply the macOS defaults, Touch ID for sudo, and the file limits. |
| `--adopt` | Pull a different file that is already in place into the repository. |

### Files that already exist

- An identical file: the installer replaces it.
- A different file: the installer moves it aside as `<name>.pre-stow`.

## Daily use

The files in $HOME are symlinks into this repository. Edit the files where
they are. Then run `git diff` and commit the changes.

| Task | Action |
|---|---|
| New host | Add `hosts/<host>/Brewfile` and `hosts/<host>/home/`. |
| New tool | Add `home/<tool>/`. Use the same paths as in $HOME. |
| New command | Put it in `home/<tool>/.local/bin/`. Then run `./install.sh`. |
| New alias | Put it in `home/<tool>/.config/zsh/conf.d/<nn>-<tool>.zsh`. |
| New variable or PATH entry | Put it in `home/<tool>/.config/zsh/env.d/<tool>.zsh`. |
| New function | Put it in `home/zsh/.config/zsh/functions/`. Then run `./install.sh`. |
| New command for a skill | Put it in `ai/skills/<skill>/bin/`. It is on PATH at once. |
| Find problems | Run `./doctor.sh`. It shows missing links, replaced files, and software that is not in a Brewfile. |

## Themes

The command `theme [dark|light]` comes from scriptorium.

- It reads the macOS appearance and selects a Catppuccin flavor.
- It runs the handlers in `home/<tool>/.config/theme/`.
- The flavor mapping is in `home/theme/.config/theme/provider.sh`.
- The installer builds `theme-monitor` from `darwin/theme-monitor.swift`. It prints `dark` or `light` each time the macOS appearance changes.
- To follow the appearance, run `theme-monitor | while read -r mode; do theme "$mode"; done`.

## Plugins

- `home/sheldon/.config/sheldon/plugins.toml` lists the zsh plugins.
- `install.sh` runs `sheldon lock`.
- `.zshrc` runs `sheldon source`.

## Notes

- Nothing has a pinned version, except the `local/tableplus` tap.
- The repository contains `getoptions` and `nix-direnv`. Homebrew does not
  have them.
- The Neovim configuration is not ported yet.
- The repository does not track these files: gh `hosts.yml`, the `op`
  configuration of 1Password, and the state of Claude Code.
