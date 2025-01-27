#!/usr/bin/env sh

case "$1" in
	"mocha")
		export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/themes/mocha/blue.yml"
	;;
	"latte")
		export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/themes/latte/blue.yml"
	;;
	"frappe")
		export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/themes/frappe/blue.yml"
	;;
	"macchiato")
		export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/themes/macchiato/blue.yml"
	;;
esac
