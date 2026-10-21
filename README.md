# dotfiles

Everything about these Macs lives here: apps, system settings, shell, tool configs and scripts. Homebrew installs software, [GNU Stow](https://www.gnu.org/software/stow/) links the configs, and shell scripts set macOS options. Nix is installed by hand and used only for project dev shells.

The layout follows the Nix setup it replaced:

```
darwin/                 system level, shared by every host        (was darwin/*.nix)
  Brewfile              CLI tools, casks, fonts, Mac App Store apps
  defaults.sh           macOS settings
  sudo-touchid.sh       Touch ID for sudo
  maxfiles.sh           launchd file-descriptor limit (nix-daemon needs it)
  taps/<name>/Casks/    casks that are not on GitHub (tableplus, container)
home/<tool>/...         one stow package per tool, mirroring $HOME   (was home/<tool>.nix)
home/bin/.local/bin/    scripts on PATH
hosts/<host>/           everything that differs per Mac           (was hosts/<host>/configuration.nix)
  Brewfile              extra casks, formulae, taps, App Store apps
  home/...              files stowed over the shared ones: git identity and signing key, SSH agent socket
ai/                     skills, agents, plugins and rules, shared by Claude Code, OpenCode and ~/.agents
install.sh              apply everything                          (was darwin-rebuild switch)
doctor.sh               report drift
```

Hosts: `mbp`, `mbp-unique`. A new host is a `hosts/<host>/` directory with a `Brewfile` and a `home/` overlay.

## Use

```sh
./install.sh [host]        # taps, brew bundle, stow, bat cache, scriptorium
./install.sh --macos       # also apply the darwin/*.sh scripts (prompts for sudo)
./install.sh --adopt       # pull differing files already in $HOME into the repo
./doctor.sh                # report missing, replaced or undeclared items
```

## Two-way sync

Files in `$HOME` are symlinks into this repo, so editing `~/.config/foo/bar` edits the repo file. Review with `git diff`, then commit.

- Software: install with `brew install` as usual; `./doctor.sh` lists what is installed but not in a Brewfile.
- Per-host differences are plain files that the shared config includes (git `config.local`, zsh `env.d/`), not templates.
- If an app replaces a symlink with a real file, `doctor.sh` reports `not-link`; `./install.sh --adopt` moves it back.
- `~/.claude/skills`, `agents` and the OpenCode equivalents are directory symlinks into `ai/`. New skills land in `git status`.
- Not tracked: `gh/hosts.yml`, 1Password's `op` config, Claude Code runtime state, `~/.config/eza/theme.yml` (the theme switcher rewrites it).

## New Mac

1. Install Nix by hand with the [Determinate installer](https://docs.determinate.systems/).
2. Install Homebrew from https://brew.sh.
3. `git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh --macos`
4. Run `./doctor.sh`.

Files that already exist where a link goes are replaced when identical and moved aside as `<name>.pre-stow` when they differ.

## Differences from the old Nix setup

- No pinning: Homebrew and the App Store install the latest. The only pin is the `local/tableplus` tap in `darwin/taps/`.
- `scriptorium` and `validate-mermaid` come from `scriptorium-install` and `npm ci`; they are not Homebrew packages.
- `nix-direnv` is vendored in `home/direnv` (no Homebrew formula).
- Neovim is not ported yet; the `neovim` formula is installed with no config.
- `k9s` is new here: its Nix module existed but was never imported.
- AI tools link only portable config: rules, skills, agents, plugins, `opencode.json`, `tui.json`, Claude `settings.json` and ccstatusline settings. History, sessions, caches, `settings.local.json`, backups and `node_modules` stay out.
