# plugins from plugins.toml (scriptorium: theme, cz, dotenv, jwt); runs before the other snippets
(( $+commands[sheldon] )) && eval "$(sheldon source)"
