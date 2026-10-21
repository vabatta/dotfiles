# k9s reads ~/Library/Application Support on macOS unless XDG_CONFIG_HOME is set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

theme_k9s() {
  local theme="$1"
  local cfg="$XDG_CONFIG_HOME/k9s/skins/catppuccin-$theme.yaml"

  if [[ -f "$cfg" ]]; then
    export K9S_SKIN="catppuccin-$theme"
  else
    unset K9S_SKIN
  fi
}

THEME_FUNCS+=("theme_k9s")
