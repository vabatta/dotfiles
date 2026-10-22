# `theme` is scriptorium's orchestrator. It cannot change this shell, so its handlers write
# ~/.local/state/theme/env.zsh and this wrapper sources it.
theme() {
  command theme "$@" || return
  source "${XDG_STATE_HOME:-$HOME/.local/state}/theme/env.zsh"
  theme_zsh_highlight "$THEME_VARIANT"
}
