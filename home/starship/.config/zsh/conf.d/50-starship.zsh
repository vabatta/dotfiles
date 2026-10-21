if [[ $TERM != "dumb" ]] && (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
