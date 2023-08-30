# vim:ft=ruby

if OS.mac?
    tap "homebrew/cask"
    tap "homebrew/cask-fonts"
    tap "homebrew/cask-versions"

    brew "mas" # Mac App Store CLI
    brew "noti" # utility to display notifications from scripts
    brew "trash" # rm, but put in the trash rather than completely delete
    brew "pinentry-mac" # pinentry for gpg (mac specific)

    # Applications from Cask
    cask "wezterm" # a better terminal emulator
    cask "imageoptim" # a tool to optimize images
    cask "1password" # 1password
    cask "1password-cli" # 1password cli
    cask "raycast" # better spotlight instead of alfred
    cask "keepingyouawake" # prevent sleep
    cask "docker" # Docker
    cask "firefox-developer-edition" # Firefox Developer Edition
    cask "google-chrome" # Google Chrome
    cask "visual-studio-code" # Visual Studio Code
    cask "vlc" # better video playback
    cask "coconutbattery" # battery status
    cask "spotify" # Spotify
    cask "protonvpn" # ProtonVPN
    cask "gswitch" # switch between graphics cards (for intel/amd)
    cask "betterdisplay" # better external displays support
    cask "gpg-suite-no-mail" # GPG Suite
    cask "discord" # Discord

    # Applications from App Store
    mas "magnet", id: 441258766 # Magnet window manager

    # Fonts
    cask "font-fira-code"
    cask "font-fira-code-nerd-font"
    cask "font-jetbrains-mono"
    cask "font-jetbrains-mono-nerd-font"
elsif OS.linux?
    brew "xclip" # access to clipboard (similar to pbcopy/pbpaste)
end

tap "homebrew/bundle"
tap "homebrew/core"

# system packages
brew "zsh" # zsh (latest)
brew "sheldon" # shell plugin manager
brew "git" # Git version control (latest version)
brew "vim" # Vim (latest)
brew "python" # python (latest)
brew "gnupg" # gpg (latest)
brew "wget" # internet file retriever
brew "tmux" # terminal multiplexer

# system alternatives
brew "fzf" # fuzzy file searcher, used in scripts and in vim
brew "bat" # better cat
brew "exa" # better ls
brew "fd" # better find
brew "ripgrep" # very fast file searcher
brew "neovim" # A better vim

# live in the cli
brew "tree" # pretty-print directory contents
brew "glow" # markdown viewer
brew "jq" # json viewer
brew "cloc" # lines of code counter

# develop in the cli
brew "asdf" # tooling version manager
brew "pnpm" # pnpm package manager
brew "gh" # GitHub CLI
brew "git-delta" # a better git diff
brew "git-lfs" # git large files handler
brew "commitizen" # commitizen cli tool for git commits

# other utilities
brew "entr" # file watcher / command runner
brew "wdiff" # word differences in text files
brew "z" # switch between most used directories

# system stats
brew "htop" # a top alternative
brew "neofetch" # pretty system info
