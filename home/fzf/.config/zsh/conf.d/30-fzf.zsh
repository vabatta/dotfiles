FZF_TMUX_HEIGHT="50%"

if [[ $options[zle] = on ]] && (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# format description of completion candidates properly
zstyle ':completion:*:descriptions' format '[%d]'

# make fzf-tab follow FZF_DEFAULT_OPTS
# NOTE: this may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# fzf-tab preview strategy:
# - File/directory completions: delegate to `less` via LESSOPEN
# - Non-file completions (git branches, PIDs, ssh hosts): use command-specific zstyles with $word
#   These can't use LESSOPEN since there's no file to preprocess

# default: use `less` for file previews (LESSOPEN/batpipe handles the rendering)
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'less ${(Q)realpath}'

# --- non-file previews (use $word instead of $realpath) ---

# environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
  'echo ${(P)word}'

# commands (man page)
zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
  'MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word"'

# git branches
zstyle ':fzf-tab:complete:git-(checkout|switch):*' fzf-preview \
  'git log --oneline --graph --color=always $word 2>/dev/null'
# git files
zstyle ':fzf-tab:complete:git-(diff|add):*' fzf-preview \
  'git diff --color=always $word 2>/dev/null'

# processes (kill)
zstyle ':fzf-tab:complete:kill:*' fzf-preview \
  'ps -p $word -o pid,user,%cpu,%mem,stat,start,command'

# ssh hosts
zstyle ':fzf-tab:complete:ssh:*' fzf-preview \
  'grep -A5 "Host $word" ~/.ssh/config 2>/dev/null || echo "No config found"'
