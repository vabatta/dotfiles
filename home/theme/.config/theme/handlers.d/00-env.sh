# runs first (handlers run alphabetically): starts a fresh state file
theme_handler_00_env() {
  : >"$THEME_ENV"
  theme_emit_export THEME "$THEME"
  theme_emit_export THEME_VARIANT "$THEME_VARIANT"
  theme_emit_export THEME_ACCENT "$THEME_ACCENT"
}
