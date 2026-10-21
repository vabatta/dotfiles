theme_detector_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || return 1
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
    THEME_APPEARANCE=dark
  else
    THEME_APPEARANCE=light
  fi
}
