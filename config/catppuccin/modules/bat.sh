#!/usr/bin/env sh

case "$1" in
	"mocha")
		export BAT_THEME="CatppuccinMocha"
	;;
	"latte")
		export BAT_THEME="CatppuccinLatte"
	;;
	"frappe")
		export BAT_THEME="CatppuccinFrappe"
	;;
	"macchiato")
		export BAT_THEME="CatppuccinMacchiato"
	;;
esac
