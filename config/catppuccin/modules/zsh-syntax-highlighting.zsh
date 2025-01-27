#!/usr/bin/env zsh

case "$1" in
	"mocha")
		# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
		#
		## General
		### Diffs
		### Markup
		## Classes
		## Comments
		ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70'
		## Constants
		## Entitites
		## Functions/methods
		ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[function]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6e3a1,italic'
		ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fab387,italic'
		ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fab387'
		ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fab387'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#cba6f7'
		## Keywords
		## Built ins
		ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6e3a1'
		ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6e3a1'
		## Punctuation
		ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f38ba8'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#f38ba8'
		ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#f38ba8'
		ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#f38ba8'
		## Serializable / Configuration Languages
		## Storage
		## Strings
		ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#f9e2af'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#f9e2af'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f9e2af'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#eba0ac'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f9e2af'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#eba0ac'
		ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#f9e2af'
		## Variables
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#eba0ac'
		ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[assign]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#cdd6f4'
		## No category relevant in spec
		ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#eba0ac'
		ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
		ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f38ba8,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cdd6f4,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8,underline'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'
		#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#eba0ac'
		ZSH_HIGHLIGHT_STYLES[redirection]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[default]='fg=#cdd6f4'
		ZSH_HIGHLIGHT_STYLES[cursor]='fg=#cdd6f4'
	;;
	"latte")
		# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
		#
		## General
		### Diffs
		### Markup
		## Classes
		## Comments
		ZSH_HIGHLIGHT_STYLES[comment]='fg=#acb0be'
		## Constants
		## Entitites
		## Functions/methods
		ZSH_HIGHLIGHT_STYLES[alias]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[function]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[command]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[precommand]='fg=#40a02b,italic'
		ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fe640b,italic'
		ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fe640b'
		ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fe640b'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#8839ef'
		## Keywords
		## Built ins
		ZSH_HIGHLIGHT_STYLES[builtin]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#40a02b'
		ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#40a02b'
		## Punctuation
		ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#d20f39'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#d20f39'
		ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#d20f39'
		ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#d20f39'
		## Serializable / Configuration Languages
		## Storage
		## Strings
		ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#df8e1d'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#df8e1d'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#df8e1d'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#e64553'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#df8e1d'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#e64553'
		ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#df8e1d'
		## Variables
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#e64553'
		ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[assign]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#4c4f69'
		## No category relevant in spec
		ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#e64553'
		ZSH_HIGHLIGHT_STYLES[path]='fg=#4c4f69,underline'
		ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#d20f39,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#4c4f69,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#d20f39,underline'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#8839ef'
		#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#e64553'
		ZSH_HIGHLIGHT_STYLES[redirection]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[arg0]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[default]='fg=#4c4f69'
		ZSH_HIGHLIGHT_STYLES[cursor]='fg=#4c4f69'
	;;
	"frappe")
		# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
		#
		## General
		### Diffs
		### Markup
		## Classes
		## Comments
		ZSH_HIGHLIGHT_STYLES[comment]='fg=#626880'
		## Constants
		## Entitites
		## Functions/methods
		ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[function]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[command]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6d189,italic'
		ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#ef9f76,italic'
		ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ef9f76'
		ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ef9f76'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#ca9ee6'
		## Keywords
		## Built ins
		ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6d189'
		ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6d189'
		## Punctuation
		ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#e78284'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#e78284'
		ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#e78284'
		ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#e78284'
		## Serializable / Configuration Languages
		## Storage
		## Strings
		ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#e5c890'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#e5c890'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#e5c890'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#ea999c'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#e5c890'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#ea999c'
		ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#e5c890'
		## Variables
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#ea999c'
		ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[assign]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#c6d0f5'
		## No category relevant in spec
		ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ea999c'
		ZSH_HIGHLIGHT_STYLES[path]='fg=#c6d0f5,underline'
		ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#e78284,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#c6d0f5,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#e78284,underline'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#ca9ee6'
		#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ea999c'
		ZSH_HIGHLIGHT_STYLES[redirection]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[arg0]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[default]='fg=#c6d0f5'
		ZSH_HIGHLIGHT_STYLES[cursor]='fg=#c6d0f5'
	;;
	"macchiato")
		# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
		#
		## General
		### Diffs
		### Markup
		## Classes
		## Comments
		ZSH_HIGHLIGHT_STYLES[comment]='fg=#5b6078'
		## Constants
		## Entitites
		## Functions/methods
		ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[function]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[command]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6da95,italic'
		ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#f5a97f,italic'
		ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f5a97f'
		ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f5a97f'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#c6a0f6'
		## Keywords
		## Built ins
		ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6da95'
		ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6da95'
		## Punctuation
		ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#ed8796'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#ed8796'
		ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#ed8796'
		ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#ed8796'
		## Serializable / Configuration Languages
		## Storage
		## Strings
		ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#eed49f'
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#eed49f'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#eed49f'
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#ee99a0'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#eed49f'
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#ee99a0'
		ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#eed49f'
		## Variables
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#ee99a0'
		ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[assign]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#cad3f5'
		## No category relevant in spec
		ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ee99a0'
		ZSH_HIGHLIGHT_STYLES[path]='fg=#cad3f5,underline'
		ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#ed8796,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cad3f5,underline'
		ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#ed8796,underline'
		ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#c6a0f6'
		#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
		#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ee99a0'
		ZSH_HIGHLIGHT_STYLES[redirection]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[default]='fg=#cad3f5'
		ZSH_HIGHLIGHT_STYLES[cursor]='fg=#cad3f5'
	;;
esac
