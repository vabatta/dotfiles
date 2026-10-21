[[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
  && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Catppuccin roles for the main highlighter:
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
theme_zsh_highlight() {
  local comment green peach mauve red yellow maroon text
  case "$1" in
    mocha)     comment=585b70 green=a6e3a1 peach=fab387 mauve=cba6f7 red=f38ba8 yellow=f9e2af maroon=eba0ac text=cdd6f4 ;;
    latte)     comment=acb0be green=40a02b peach=fe640b mauve=8839ef red=d20f39 yellow=df8e1d maroon=e64553 text=4c4f69 ;;
    frappe)    comment=626880 green=a6d189 peach=ef9f76 mauve=ca9ee6 red=e78284 yellow=e5c890 maroon=ea999c text=c6d0f5 ;;
    macchiato) comment=5b6078 green=a6da95 peach=f5a97f mauve=c6a0f6 red=ed8796 yellow=eed49f maroon=ee99a0 text=cad3f5 ;;
    *) return ;;
  esac

  local k
  ZSH_HIGHLIGHT_STYLES[comment]="fg=#$comment"
  for k in alias suffix-alias global-alias function command builtin reserved-word hashed-command; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$green"
  done
  for k in single-hyphen-option double-hyphen-option; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$peach"
  done
  for k in back-quoted-argument history-expansion; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$mauve"
  done
  for k in commandseparator back-quoted-argument-delimiter back-double-quoted-argument back-dollar-quoted-argument; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$red"
  done
  for k in command-substitution-quoted command-substitution-delimiter-quoted single-quoted-argument double-quoted-argument rc-quote; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$yellow"
  done
  for k in single-quoted-argument-unclosed double-quoted-argument-unclosed dollar-quoted-argument-unclosed unknown-token back-quoted-argument-unclosed; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$maroon"
  done
  for k in command-substitution-delimiter command-substitution-delimiter-unquoted process-substitution-delimiter \
    dollar-quoted-argument dollar-double-quoted-argument assign named-fd numeric-fd globbing redirection arg0 default cursor; do
    ZSH_HIGHLIGHT_STYLES[$k]="fg=#$text"
  done
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=#$green,italic"
  ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=#$peach,italic"
  ZSH_HIGHLIGHT_STYLES[path]="fg=#$text,underline"
  ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=#$text,underline"
  ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=#$red,underline"
  ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=#$red,underline"
}

THEME_FUNCS+=("theme_zsh_highlight")
