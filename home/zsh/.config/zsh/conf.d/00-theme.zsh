declare -ga THEME_FUNCS

themeup() {
  local theme="$1"
  local accent="$2"

  # Auto-detect if no args and running on macOS
  if [[ -z "$theme" ]]; then
    if [[ "$OSTYPE" == darwin* ]]; then
      local appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")

      case "$appearance" in
        Dark) theme="mocha" ;;
        *) theme="latte" ;;
      esac

      accent="blue" # could be made dynamic later
    else
      echo "Usage: themeup <theme> <accent>" >&2
      return 1
    fi
  fi

  if [[ -z "$accent" ]]; then
    echo "Usage: themeup <theme> <accent>" >&2
    return 1
  fi

  for func in "${THEME_FUNCS[@]}"; do
    if command -v "$func" >/dev/null; then
      "$func" "$theme" "$accent"
    fi
  done
}
