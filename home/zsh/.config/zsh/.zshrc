typeset -U path cdpath fpath manpath
fpath+=(/opt/homebrew/share/zsh/site-functions)

REPORTTIME=10 # display how long all tasks over 10 seconds take
KEYTIMEOUT=1  # 10ms delay for key sequences

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY \
  NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST \
  NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# default to file completion
zstyle ':completion:*' completer _expand _complete _files _correct _approximate
# enable verbose mode for zsh completion system
zstyle ':completion:*' verbose yes
# set the format for messages shown during completion
zstyle ':completion:*:messages' format '%d'
# customize the format of warnings when no matches are found
zstyle ':completion:*:warnings' format 'No matches for: %d'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

autoload -U compinit && compinit

# fixed prefix: `brew --prefix` is too slow for shell startup
brew_share=/opt/homebrew/share
[[ -r $brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)
[[ -r $brew_share/fzf-tab/fzf-tab.zsh ]] && source $brew_share/fzf-tab/fzf-tab.zsh

# plugins from sheldon (scriptorium: theme, cz, dotenv, jwt)
(( $+commands[sheldon] )) && eval "$(sheldon source)"

# snippets from the tool packages; 00 defines the `theme` wrapper, 90 loads syntax highlighting last
for f in "$ZDOTDIR"/conf.d/*.zsh(N); do source "$f"; done
unset f

# small custom functions, one per file (scripts/ package)
for f in "$ZDOTDIR"/functions/*.zsh(N); do source "$f"; done
unset f
[[ -r $ZDOTDIR/local.zsh ]] && source "$ZDOTDIR/local.zsh"

(( $+commands[theme] )) && theme
