#!/usr/bin/env bash
# macOS system settings, ported from nix-darwin's system.defaults. Idempotent.
set -euo pipefail

# Safari and Mail are sandboxed: the write fails unless the terminal has Full Disk Access.
try() { "$@" || echo "skipped (grant the terminal Full Disk Access): $*" >&2; }

defaults write com.apple.dock magnification -bool true

for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write "$domain" Clicking -bool false
  defaults write "$domain" TrackpadThreeFingerDrag -bool true
  defaults write "$domain" TrackpadRightClick -bool true
done

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g AppleKeyboardUIMode -int 3
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

try defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
try defaults write com.apple.Safari IncludeDevelopMenu -bool true
try defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
try defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
try defaults write com.apple.Mail DisableInlineAttachmentViewing -bool true

killall Dock Finder || true

# System-wide settings: these prompt for sudo.
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true
# startup chime off
sudo nvram StartupMute=%01
