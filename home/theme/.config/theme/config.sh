# `theme` runs as a child process, so handlers cannot export into the shell. They append shell code
# to this file instead, and the zsh `theme` wrapper sources it (home/theme/.config/zsh/conf.d).
THEME_ENV="${XDG_STATE_HOME:-$HOME/.local/state}/theme/env.zsh"
mkdir -p "${THEME_ENV%/*}"

theme_emit_export() { printf 'export %s=%q\n' "$1" "$2" >>"$THEME_ENV"; }
