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

theme_fzf() {
  local theme="$1"
  # ignore accent
  local colors=""

  case "$theme" in
    mocha)
      colors="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
              --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
              --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
              --color=selected-bg:#45475a"
      ;;
    latte)
      colors="--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
              --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
              --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
              --color=selected-bg:#bcc0cc"
      ;;
    frappe)
      colors="--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
              --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
              --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
              --color=selected-bg:#51576d"
      ;;
    macchiato)
      colors="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
              --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
              --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
              --color=selected-bg:#494d64"
      ;;
  esac

  # remove existing --color options to avoid conflicts
  local cleaned="${FZF_DEFAULT_OPTS//--color[^ ]*/}"

  export FZF_DEFAULT_OPTS="$cleaned $colors"
}

THEME_FUNCS+=("theme_fzf")
