#!/bin/bash

if [ -n "$CLAUDE_SETTINGS_JSON" ]; then
    echo "$CLAUDE_SETTINGS_JSON" > /home/developer/.claude/settings.json
fi

# Start SSH server
exec /usr/sbin/sshd -D
