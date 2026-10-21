theme_bottom() {
  local theme="$1"
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/bottom/themes/$theme.toml"
  # ignore accent

  if [[ -f "$cfg" ]]; then
    export BTM_CONFIG_FILE="$cfg"
    alias btm="btm -C $BTM_CONFIG_FILE"
  else
    unalias btm 2>/dev/null
  fi
}

THEME_FUNCS+=("theme_bottom")
