# vim:ft=ruby

tap "homebrew/bundle"

if OS.mac?
	# Daily use applications
	cask "1password" # 1password
	cask "1password-cli" # 1password cli
	cask "raycast" # better spotlight instead of alfred
	cask "google-chrome" # Google Chrome
	cask "discord" # Discord
	cask "spotify" # Spotify
	cask "iina" # modern video player
	cask "obsidian" # Obsidian note taking

	# Utilities applications
	brew "mas" # Mac App Store CLI
	brew "trash" # rm, but put in the trash rather than completely delete
	cask "keepingyouawake" # prevent sleep
	cask "betterdisplay" # better external displays support
	cask "coconutbattery" # battery status
	cask "jordanbaird-ice" # top status bar manager
	cask "imageoptim" # a tool to optimize images
	cask "handbrake" # a tool to convert videos

	# Development applications
	cask "wezterm" # a better terminal emulator
	cask "ghostty" # a way better terminal emulator
	cask "docker" # Docker
	cask "firefox@developer-edition" # Firefox Developer Edition
	cask "visual-studio-code" # Visual Studio Code
	cask "responsively" # a tool to develop responsive websites
	cask "figma" # Figma

	# Applications from App Store
	mas "magnet", id: 441258766 # Magnet window manager
	mas "yoink", id: 457622435 # drag-n-drop on-screen widget

	# Fonts
	cask "font-fira-code-nerd-font"
	cask "font-jetbrains-mono-nerd-font"
	cask "font-hack-nerd-font"
	cask "font-monoid-nerd-font"
elsif OS.linux?
	brew "xclip" # access to clipboard (similar to pbcopy/pbpaste)
end

# system packages
brew "zsh" # zsh (latest)
brew "git" # Git version control (latest)
brew "make" # make (latest)
brew "sheldon" # shell plugin manager
brew "tmux" # terminal multiplexer

# system alternatives
brew "fzf" # fuzzy file searcher, used in scripts and in vim
brew "bat" # better cat
brew "bat-extras" # additional bat features
brew "eza" # better ls
brew "fd" # better find
brew "ripgrep" # very fast file searcher

# live & develop in the cli
brew "neovim" # A better vim
brew "lazygit" # a better git ui
brew "mise" # tooling version manager
brew "gh" # GitHub CLI
brew "tree" # pretty-print directory contents
brew "glow" # markdown viewer
brew "jq" # json viewer
brew "cloc" # lines of code counter

# other utilities
brew "entr" # file watcher / command runner
brew "wdiff" # word differences in text files
brew "zoxide" # switch between most used directories
brew "tree-sitter" # better syntax highlighting library
brew "git-lfs" # git large files handler
brew "parallel" # parallelize shell commands
brew "noti" # display notifications from scripts

# system stats
brew "bottom" # a top alternative with integrations
brew "htop" # a top alternative
brew "fastfetch" # pretty system info
