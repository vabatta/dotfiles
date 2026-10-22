theme_handler_vivid() {
  theme_emit_export LS_COLORS "$(vivid generate "catppuccin-$THEME_VARIANT")"
}
