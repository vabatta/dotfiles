export VIVID_THEME="catppuccin-latte"

theme_ls_colors() {
  local theme="$1"
  case "$theme" in
    mocha)     export LS_COLORS="$(vivid generate catppuccin-mocha)" ;;
    latte)     export LS_COLORS="$(vivid generate catppuccin-latte)" ;;
    frappe)    export LS_COLORS="$(vivid generate catppuccin-frappe)" ;;
    macchiato) export LS_COLORS="$(vivid generate catppuccin-macchiato)" ;;
    *) unset LS_COLORS ;;
  esac
}

THEME_FUNCS+=("theme_ls_colors")
