export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

export EDITOR="vim"
export GIT_EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# /etc/zprofile's path_helper reorders PATH on login shells, so this runs again from .zprofile
typeset -U path
path=("$HOME/.local/bin" /opt/homebrew/bin /opt/homebrew/sbin $path)
# Nix is installed by hand (Determinate installer) and only used for project dev shells
[[ -d /nix/var/nix/profiles/default/bin ]] && path+=(/nix/var/nix/profiles/default/bin)

# tool packages ship their own variables here
for f in "$ZDOTDIR"/env.d/*.zsh(N); do source "$f"; done
unset f
