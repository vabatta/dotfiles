#!/usr/bin/env bash
# Audit a change against a line budget.
# Usage: diff-budget.sh [--budget N] [--base REF]
# Counts net added lines (added minus deleted) in source files, excluding tests,
# generated files, lockfiles, prose (md, txt, tsv, rst), docs/, and .agent/. Includes staged, unstaged, and untracked work.
# Exits 1 when the net exceeds the budget.
set -eu

budget=""
base="HEAD"
while [ $# -gt 0 ]; do
  case "$1" in
    --budget) budget="${2:?--budget needs a number}"; shift 2 ;;
    --base) base="${2:?--base needs a ref}"; shift 2 ;;
    *) printf 'usage: %s [--budget N] [--base REF]\n' "$0" >&2; exit 2 ;;
  esac
done

skip='(^|/)(docs?|\.agent)/|\.(md|mdx|txt|tsv|rst|adoc)$|(^|/)(tests?|__tests__|spec|dist|build|generated|vendor|node_modules)/|\.(test|spec|min|snap|lock)\.|\.lock$|(^|/)(package-lock\.json|pnpm-lock\.yaml|go\.sum|flake\.lock)$'
manifests='(^|/)(package\.json|Cargo\.toml|go\.mod|pyproject\.toml|requirements.*\.txt|Gemfile|flake\.nix|build\.gradle(\.kts)?|pom\.xml)$|(^|/)(package-lock\.json|pnpm-lock\.yaml|Cargo\.lock|go\.sum|flake\.lock|poetry\.lock)$'

rows="$({
  git diff --numstat "$base" --
  git ls-files --others --exclude-standard | while IFS= read -r f; do
    printf '%s\t0\t%s\n' "$(wc -l < "$f" | tr -d ' ')" "$f"
  done
})"

net=0 files=0
while IFS="$(printf '\t')" read -r add del path; do
  [ -n "$path" ] || continue
  case "$add" in -) continue ;; esac
  if printf '%s' "$path" | grep -Eq "$skip"; then continue; fi
  net=$((net + add - del))
  files=$((files + 1))
done <<EOT
$rows
EOT

new_files="$(git ls-files --others --exclude-standard; git diff --name-only --diff-filter=A "$base" --)"
new_count=0
[ -z "$new_files" ] || new_count="$(printf '%s\n' "$new_files" | sort -u | grep -Evc "$skip" || true)"
touched="$({ git diff --name-only "$base" --; git ls-files --others --exclude-standard; } | sort -u | grep -E "$manifests" || true)"

printf 'net added lines: %s (across %s counted files, base %s)\n' "$net" "$files" "$base"
[ "$files" -gt 0 ] || printf 'no source files changed (prose, docs, tests, and generated files are not counted)\n'
printf 'new source files: %s\n' "$new_count"
if [ -n "$touched" ]; then
  printf 'manifests or lockfiles changed, justify each new entry:\n'
  printf '  %s\n' $touched
else
  printf 'manifests or lockfiles changed: none\n'
fi

if [ -n "$budget" ]; then
  if [ "$net" -gt "$budget" ]; then
    printf 'OVER BUDGET: %s > %s\n' "$net" "$budget"
    exit 1
  fi
  printf 'within budget: %s <= %s\n' "$net" "$budget"
fi
