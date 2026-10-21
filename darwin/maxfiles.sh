#!/usr/bin/env bash
# Raises launchd's file-descriptor limit (default 256). nix-daemon, kept for dev shells,
# hits EMFILE on large parallel fetches without it. Ported from nix-darwin's limit-maxfiles daemon.
set -euo pipefail

[[ $EUID -eq 0 ]] || exec sudo "$0" "$@"

plist=/Library/LaunchDaemons/limit.maxfiles.plist
cat >"$plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>limit.maxfiles</string>
	<key>ProgramArguments</key>
	<array>
		<string>launchctl</string>
		<string>limit</string>
		<string>maxfiles</string>
		<string>245760</string>
		<string>491520</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>ServiceIPC</key>
	<false/>
</dict>
</plist>
EOF
chown root:wheel "$plist"
chmod 644 "$plist"
launchctl bootout system/limit.maxfiles 2>/dev/null || true
launchctl bootstrap system "$plist"
