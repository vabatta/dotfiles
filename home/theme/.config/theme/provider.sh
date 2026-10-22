# dark and light map to a Catppuccin flavour (latte, frappe, macchiato, mocha) and an accent
theme_provider_catppuccin() {
  export THEME="$1"
  case "$1" in
    dark) export THEME_VARIANT=mocha ;;
    *) export THEME_VARIANT=latte ;;
  esac
  export THEME_ACCENT=blue
}
