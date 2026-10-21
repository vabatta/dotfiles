theme_handler_bottom() {
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/bottom/themes/$THEME_VARIANT.toml"

  if [[ -f "$cfg" ]]; then
    theme_emit_export BTM_CONFIG_FILE "$cfg"
    printf 'alias btm=%q\n' "btm -C $cfg" >>"$THEME_ENV"
  else
    printf 'unset BTM_CONFIG_FILE\nunalias btm 2>/dev/null\n' >>"$THEME_ENV"
  fi
}
