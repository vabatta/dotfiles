#!/usr/bin/env bash
# Touch ID for sudo via /etc/pam.d/sudo_local, which survives macOS updates. Idempotent.
set -euo pipefail

[[ $EUID -eq 0 ]] || exec sudo bash "$0" "$@"

file=/etc/pam.d/sudo_local
enabled='^auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so'

grep -Eqs "$enabled" "$file" && exit 0

# a symlink here is a leftover nix-darwin /etc/static link
[[ -L $file ]] && rm "$file"
if [[ -f $file ]]; then
  echo 'auth       sufficient     pam_tid.so' >>"$file"
else
  sed -E 's/^#(auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so)/\1/' "$file.template" >"$file"
fi
grep -Eq "$enabled" "$file"
