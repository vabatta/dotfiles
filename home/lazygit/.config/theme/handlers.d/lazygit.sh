theme_handler_lazygit() {
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit/themes/$THEME_VARIANT/$THEME_ACCENT.yml"

  if [[ -f "$cfg" ]]; then
    theme_emit_export LG_CONFIG_FILE "$cfg"
  else
    printf 'unset LG_CONFIG_FILE\n' >>"$THEME_ENV"
  fi
}
