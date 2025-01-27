#!/usr/bin/env bash

# List of available themes
CATPPUCCIN_THEMES=("latte" "mocha" "frappe" "macchiato")

# Default theme fallback
CATPPUCCIN_THEME="${CATPPUCCIN_THEME:-"latte"}"

# Modules to source
CATPPUCCIN_MODULES=(
	"bat.sh"
	"fzf.sh"
	"lazygit.sh"
	"zsh-syntax-highlighting.zsh"
)

# map light/dark themes to their respective themes
case $CATPPUCCIN_THEME in
	"light")
		CATPPUCCIN_THEME="latte"
	;;
	"dark")
		CATPPUCCIN_THEME="mocha"
	;;
esac

if [[ ! " ${CATPPUCCIN_THEMES[@]} " =~ " $CATPPUCCIN_THEME " ]]; then
	echo "Error: Invalid theme '$CATPPUCCIN_THEME'. Available themes: ${CATPPUCCIN_THEMES[@]}."
	# exit 1
fi

for module in "${CATPPUCCIN_MODULES[@]}"; do
	module_with_path="$XDG_CONFIG_HOME/catppuccin/modules/$module"
	# echo "Sourcing module: $module_with_path $CATPPUCCIN_THEME"
	if [[ -f "$module_with_path" ]]; then
		source "$module_with_path" "$CATPPUCCIN_THEME"
	else
		echo "Warning: Module '$module_with_path' not found, skipping."
	fi
done
