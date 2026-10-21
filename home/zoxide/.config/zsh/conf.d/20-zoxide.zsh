if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
  alias cd=z
fi
