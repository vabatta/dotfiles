# lazygit reads ~/Library/Application Support on macOS unless XDG_CONFIG_HOME is set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

theme_lazygit() {
  local theme="$1"
  local accent="$2"
  local cfg="$XDG_CONFIG_HOME/lazygit/themes/$theme/$accent.yml"

  if [[ -f "$cfg" ]]; then
    export LG_CONFIG_FILE="$cfg"
  else
    unset LG_CONFIG_FILE
  fi
}

THEME_FUNCS+=("theme_lazygit")
