# Nix is installed by hand (Determinate installer) and only used for project dev shells
[[ -d /nix/var/nix/profiles/default/bin ]] && path+=(/nix/var/nix/profiles/default/bin)
