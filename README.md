# dotfiles

My macOS setup. Homebrew installs the software. GNU Stow links the
configuration files. A few shell scripts set the macOS options. Nix is
installed by hand. It is only for project dev shells.

## Layout

| Path | Contents |
|---|---|
| `darwin/` | Brewfile, macOS defaults, and local taps. Every host uses them. |
| `home/` | One stow package for each tool, laid out like $HOME. |
| `hosts/` | A Brewfile and a `home/` overlay for each host (git identity, SSH agent). |
| `scripts/` | `bin/` links to `~/.local/bin`. `functions/` links to `~/.config/zsh/functions`. |
| `ai/` | Skills, agents, and rules for Claude Code and OpenCode. |
| `install.sh` | Apply everything. |
| `doctor.sh` | Show where this Mac differs from the repository. |

## Install

1. Install Nix: https://docs.determinate.systems/
2. Install Homebrew: https://brew.sh
3. Clone the repository and run the installer:

        git clone <repo> ~/dotfiles
        cd ~/dotfiles
        ./install.sh --macos

4. Run `./doctor.sh` to find problems.

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
| New script | Put it in `scripts/bin/`. Then run `./install.sh`. |
| New function | Put it in `scripts/functions/`. Then run `./install.sh`. |
| New command for a skill | Put it in `ai/skills/<skill>/bin/`. It is on PATH at once. |
| Find problems | Run `./doctor.sh`. It shows missing links, replaced files, and software that is not in a Brewfile. |

## Themes

The command `theme [dark|light]` comes from scriptorium.

- It reads the macOS appearance and selects a Catppuccin flavor.
- It runs the handlers in `home/<tool>/.config/theme/`.
- The flavor mapping is in `home/theme/.config/theme/provider.sh`.

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
