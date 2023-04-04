# Dotfiles

This is a personal adaptation of [nicknisi's dotfiles](https://github.com/nicknisi/dotfiles/) to better suit my needs and my setup.
It it basically a stream-lined setup for zsh to accomplish a minimal, but productive, environment with a touch of ol' style grooves with
[Gruvbox](https://github.com/morhetz/gruvbox-contrib) themes.

## Initial setup

The first thing you need to do is to clone this repo into a location of your choosing. For example, if you have a `~/Developer` directory where you clone all of your git repos, that's a good choice for this one, too. This repo is setup to not rely on the location of the dotfiles, so you can place it anywhere.

> **Note**
> If you're on macOS, you'll also need to install the XCode CLI tools before continuing.

```bash
xcode-select --install
```

```bash
git clone git@github.com:vabatta/dotfiles.git
```

> **Note**
> This dotfiles configuration is set up in such a way that it _shouldn't_ matter where the repo exists on your system.

The script, `install.sh` is the one-stop for all things setup, backup, and installation.

```bash
> ./install.sh help

Usage: install.sh {backup|link|homebrew|shell|terminfo|macos|all}
```

### `backup`

```bash
./install.sh backup
```

Create a backup of the current dotfiles (if any) into `~/.dotfiles-backup/`. This will scan for the existence of every file that is to be symlinked and will move them over to the backup directory. It will also do the same for vim setups, moving some files in the [XDG base directory](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), (`~/.config`).

- `~/.config/nvim/` - The home of [neovim](https://neovim.io/) configuration
- `~/.vim/` - The home of vim configuration
- `~/.vimrc` - The main init file for vim

### `link`

```bash
./install.sh link
```

The `link` command will create [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link) from the dotfiles directory into the `$HOME` directory, allowing for all of the configuration to _act_ as if it were there without being there, making it easier to maintain the dotfiles in isolation.

### `homebrew`

```bash
./install homebrew
```

The `homebrew` command sets up [homebrew](https://brew.sh/) by downloading and running the homebrew installers script. Homebrew is a macOS package manager, but it also work on linux via Linuxbrew. If the script detects that you're installing the dotfiles on linux, it will use that instead. For consistency between operating systems, linuxbrew is set up but you may want to consider an alternate package manager for your particular system.

Once homebrew is installed, it executes the `brew bundle` command which will install the packages listed in the [Brewfile](./Brewfile).

> Note: if you are on MacOS, make sure to be logged in the App Store or it might fail.

```bash
./install.sh appstore
```

### `shell`

```bash
./install.sh shell
```

The `shell` command sets up the recommended shell configuration for the dotfiles setup. Specifically, it sets the shell to [zsh](https://www.zsh.org/) using the `chsh` command.

### `terminfo`

```bash
./install.sh terminfo
```

This command uses `tic` to set up the terminfo, specifically to allow for _italics_ within the terminal. If you don't care about that, you can ignore this command.

### `macos`

```bash
./install.sh macos
```

The `macos` command sets up macOS-specific configurations using the `defaults write` commands to change default values for macOS.

- Finder: show all filename extensions
- show hidden files by default
- only use UTF-8 in Terminal.app
- expand save dialog by default
- Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
- Enable subpixel font rendering on non-Apple LCDs
- Use current directory as default search scope in Finder
- Show Path bar in Finder
- Show Status bar in Finder
- Disable press-and-hold for keys in favor of key repeat
- Set a blazingly fast keyboard repeat rate
- Set a shorter Delay until key repeat
- Enable Safari’s debug menu

### `all`

```bash
./install.sh all
```

This command runs all of the installation tasks described above, in full, with the exception of the `backup` script. You must run that one manually.

## ZSH Configuration

The prompt for ZSH is configured in the `zshrc.symlink` file and performs the following operations.

- Sets `EDITOR` to `nvim`
- Loads any `~/.terminfo` setup
- Sets `CODE_DIR` to `~/Developer`. This can be changed to the location you use to put your git checkouts, and enables fast `cd`-ing into it via the `c` command
- Recursively searches the `$DOTFILES/zsh` directory for any `.zsh` files and sources them
- Sources a `~/.localrc`, if available for configuration that is machine-specific and/or should not ever be checked into git
- Adds `~/bin` and `$DOTFILES/bin` to the `PATH`

### ZSH plugins

There are a number of plugins in use for ZSH, and they are installed and maintained separately via the `sheldon` manager. `Sheldon` is a plugin manager available [here](https://github.com/rossmacarthur/sheldon). The plugins that are used are listed in the `.config/sheldon` and include

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-npm-scripts-autocomplete](https://github.com/grigorii-zander/zsh-npm-scripts-autocomplete)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab)

### Prompt

Uses [Spaceship prompt](https://spaceship-prompt.sh/).

## Neovim setup

> **Note**
> This is no longer a vim setup. The configuration has been moved to be Neovim-specific and (mostly) written in [Lua](https://www.lua.org/). `vim` is also set up as an alias to `nvim` to help with muscle memory.

The simplest way to install Neovim is to install it from homebrew.

```bash
brew install neovim
```

However, it was likely installed already if you ran the `./install.sh brew` command provided in the dotfiles.

All of the configuration for Neovim starts at `config/nvim/init.lua`, which is symlinked into the `~/.config/nvim` directory.

> **Warning**
> The first time you run `nvim` with this configuration, it will likely have a lot of errors. This is because it is dependent on a number of plugins being installed.

### Installing plugins

On the first run, all required plugins should automaticaly by installed by
[lazy.nvim](https://github.com/folke/lazy.nvim), a plugin manager for neovim.

All plugins are listed in [plugins.lua](./config/nvim/lua/plugins.lua). When a plugin is added, it will automatically be installed by lazy.nvim. To interface with lazy.nvim, simply run `:Lazy` from within vim.

> **Note**
> Plugins can be synced in a headless way from the command line using the `vimu` alias.

## tmux configuration

I prefer to run everything inside of [tmux](https://github.com/tmux/tmux). I typically use a large pane on the top for neovim and then multiple panes along the bottom or right side for various commands I may need to run. There are no pre-configured layouts in this repository, as I tend to create them on-the-fly and as needed.

This repo ships with a `tm` command which provides a list of active session, or provides prompts to create a new one.

```bash
> tm
Available sessions
------------------

1) New Session
Please choose your session: 1
Enter new session name: open-source
```

This configuration provides a bit of style to the tmux bar, along with some additional data such as the currently playing song (from Apple Music or Spotify), the system name, the session name, and the current time.

> **Note**
> It also changes the prefix from `⌃-b` to `⌃-a` (⌃ is the _control_ key). This is because I tend to remap the Caps Lock button to Control, and then having the prefix makes more sense.

### tmux key commands

Pressing the Prefix followed by the following will have the following actions in tmux.

| Command     | Description                    |
| ----------- | ------------------------------ |
| `h`         | Select the pane to the left    |
| `j`         | Select the pane to the bottom  |
| `k`         | Select the pane to the top     |
| `l`         | Select the pane to the right   |
| `⇧-H`       | Enlarge the pane to the left   |
| `⇧-J`       | Enlarge the pane to the bottom |
| `⇧-K`       | Enlarge the pane to the top    |
| `⇧-L`       | Enlarge the pane to the right  |
| `-` (dash)  | Create a vertical split        |
| `\|` (pipe) | Create a horizontal split      |

## Docker Setup

A Dockerfile exists in the repository as a testing ground for linux support. To set up the image, make sure you have Docker installed and then run the following command.

```bash
docker build -t dotfiles --force-rm --build-arg PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" --build-arg PUBLIC_KEY="$(cat ~/.ssh/id_rsa.pub)" .
```

This should create a `dotfiles` image which will set up the base environment with the dotfiles repo cloned. To run, execute the following command.

```bash
docker run -it --rm dotfiles
```

This will open a bash shell in the container which can then be used to manually test the dotfiles installation process with linux.

## Preferred software

I almost exclusively work on macOS, so this list will be specific to that operating system, but several of these
reccomendations are also available, cross-platform.

- [Kitty](https://sw.kovidgoyal.net/kitty/) - A GPU-based terminal emulator

## Credits

Original dotfiles: https://github.com/nicknisi/dotfiles/
