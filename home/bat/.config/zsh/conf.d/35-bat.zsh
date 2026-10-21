theme_bat() {
  local theme="$1"
  case "$theme" in
    mocha)     export BAT_THEME="CatppuccinMocha" ;;
    latte)     export BAT_THEME="CatppuccinLatte" ;;
    frappe)    export BAT_THEME="CatppuccinFrappe" ;;
    macchiato) export BAT_THEME="CatppuccinMacchiato" ;;
    *) unset BAT_THEME ;;
  esac
}

THEME_FUNCS+=("theme_bat")
