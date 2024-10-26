# Structure

Everything is written in Lua.

## Directories

- `config/` - General vim onfiguration for plugins
	- `autocmds.lua` - Autocommands
	- `keymaps.lua` - Keymaps
	- `manager.lua` - Plugin manager
	- `options.lua` - Options
- `plugins/` - Plugins loading
- `utils/` - Utility functions

## Groups

- `ui` - Enhance the appearance and interaction of Neovim.
- `lang` - Language servers and syntax highlighting.
- `tool` - Adds functionalities to Neovim.
- `navigation` - Navigation between files and code.
- `manipulation` - Manipulation of text and code.

## Plugins

Make sure to add the require statement in `config/manager.lua` to load the plugin with the manager.
