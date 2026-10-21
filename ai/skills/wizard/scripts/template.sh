#!/usr/bin/env bash
# Interactive wizard library. Author stages below the STAGES marker only.
# Do not edit above the marker.
set -euo pipefail

TOTAL_STAGES="${TOTAL_STAGES:-0}"
CURRENT_STAGE=0

banner() {
  printf '\n========================================\n'
  printf '  %s\n' "${1:-Setup wizard}"
  printf '========================================\n'
}

stage() {
  CURRENT_STAGE=$((CURRENT_STAGE + 1))
  printf '\n-- Stage %s/%s: %s --\n' "$CURRENT_STAGE" "$TOTAL_STAGES" "$1"
}

say()     { printf '%s\n' "$1"; }
step()    { printf '  %s\n' "$1"; }
note()    { printf '  note: %s\n' "$1"; }
warn()    { printf '  warning: %s\n' "$1" >&2; }

open_url() {
  local url="$1"
  if command -v open >/dev/null 2>&1; then open "$url"
  elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$url"
  elif command -v wslview >/dev/null 2>&1; then wslview "$url"
  else warn "open this URL manually: $url"; fi
}

pause()   { read -r -p "  Press Enter to continue... " _; }
confirm() { read -r -p "  $1 [y/N] " reply; [[ "$reply" == [yY]* ]]; }

ask() {
  local var="$1" prompt="$2" value
  read -r -p "  $prompt " value
  printf -v "$var" '%s' "$value"
}

ask_secret() {
  local var="$1" prompt="$2" value
  read -r -s -p "  $prompt " value
  printf '\n'
  printf -v "$var" '%s' "$value"
}

write_env() {
  local file="$1" key="$2" value="$3" tmp rc=0
  touch "$file"
  git check-ignore -q "$file" 2>/dev/null || rc=$?
  [ "$rc" -eq 1 ] && warn "$file is not gitignored. Add it to .gitignore before committing."
  tmp="$(mktemp)"
  awk -v k="${key}=" 'index($0, k) != 1' "$file" > "$tmp"
  printf '%s=%s\n' "$key" "$value" >> "$tmp"
  cat "$tmp" > "$file"
  rm -f "$tmp"
}

set_secret() { gh secret set "$1" --body "$2"; }
set_var()    { gh variable set "$1" --body "$2"; }

finish() { printf '\nDone. %s\n' "${1:-}"; }

# ----------------------------- STAGES -----------------------------
# Add stages below, in dependency order.
#
# banner "Example wizard"
# TOTAL_STAGES=1
#
# stage "Create an API key"
# open_url "https://example.com/keys"
# step "Copy the key shown on the page."
# ask_secret API_KEY "Paste the key: "
# write_env .env EXAMPLE_API_KEY "$API_KEY"
# set_secret EXAMPLE_API_KEY "$API_KEY"
# finish
