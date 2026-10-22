#!/usr/bin/env bash
# Human-in-the-loop reproduction loop for hard-to-automate bugs.
# Last resort in diagnosing-bugs Phase 1. Prints captured KEY=VALUE at the end.
set -euo pipefail

step() {
  printf '\n== %s ==\n' "$1"
  read -r -p "Press Enter when done... " _
}

capture() {
  local var="$1" question="$2" value
  read -r -p "$question " value
  printf -v "$var" '%s' "$value"
}

printf 'HITL reproduction loop\n'

step "Reproduce the bug by following the reported steps."
capture SYMPTOM "What did you observe? "

step "Try the workaround or the suspected trigger."
capture RESULT "What changed? "

printf '\nCaptured values\n'
printf 'SYMPTOM=%s\n' "$SYMPTOM"
printf 'RESULT=%s\n' "$RESULT"
