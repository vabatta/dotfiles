theme_handler_k9s() {
  local skin="catppuccin-$THEME_VARIANT"

  if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins/$skin.yaml" ]]; then
    theme_emit_export K9S_SKIN "$skin"
  else
    printf 'unset K9S_SKIN\n' >>"$THEME_ENV"
  fi
}
