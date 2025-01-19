# Powerlevel10k prompt segments for mise
# [Feature request: add segment for mise](https://github.com/romkatv/powerlevel10k/issues/2212)
# Usage in ~/.zshrc:
#   [[ -f ~/.config/prompt/p10k.mise.zsh ]] && source ~/.config/prompt/p10k.mise.zsh

() {
	function prompt_mise() {
		# local plugins=("${(@f)$(mise ls --current --json | jq -r "with_entries(select(.value[0].source.path != \"$HOME/.config/mise/config.toml\")) | to_entries[] | [.key, .value[0].version] | join(\" \")")}")
		local plugins=("${(@f)$(mise ls --current --offline 2>/dev/null | awk '!/\(symlink\)/ && $3!="~/.tool-versions" && $3!="~/.config/mise/config.toml" {print $1, $2}')}")
		local plugin
		for plugin in ${(k)plugins}; do
			local parts=("${(@s/ /)plugin}")
			local tool=${(U)parts[1]}
			local version=${parts[2]}
			p10k segment -r -i "${tool}_ICON" -s $tool -t "$version"
		done
	}

	# Colors
	typeset -g POWERLEVEL9K_MISE_FOREGROUND=1

	typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_FOREGROUND=93
	typeset -g POWERLEVEL9K_MISE_ELIXIR_FOREGROUND=129
	typeset -g POWERLEVEL9K_MISE_ERLANG_FOREGROUND=160
	typeset -g POWERLEVEL9K_MISE_FLUTTER_FOREGROUND=33
	typeset -g POWERLEVEL9K_MISE_GO_FOREGROUND=81
	typeset -g POWERLEVEL9K_MISE_HASKELL_FOREGROUND=99
	typeset -g POWERLEVEL9K_MISE_JAVA_FOREGROUND=196
	typeset -g POWERLEVEL9K_MISE_JULIA_FOREGROUND=34
	typeset -g POWERLEVEL9K_MISE_LUA_FOREGROUND=33
	typeset -g POWERLEVEL9K_MISE_NODE_FOREGROUND=34
	typeset -g POWERLEVEL9K_MISE_PERL_FOREGROUND=33
	typeset -g POWERLEVEL9K_MISE_PHP_FOREGROUND=93
	typeset -g POWERLEVEL9K_MISE_POSTGRES_FOREGROUND=33
	typeset -g POWERLEVEL9K_MISE_PYTHON_FOREGROUND=33
	typeset -g POWERLEVEL9K_MISE_RUBY_FOREGROUND=196
	typeset -g POWERLEVEL9K_MISE_RUST_FOREGROUND=208

	# Substitute the default asdf prompt element
	typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
}