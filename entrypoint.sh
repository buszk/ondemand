#!/bin/bash

if [ -n "$CLAUDE_SETTINGS_JSON" ]; then
    mkdir -p /home/developer/.claude
    echo "$CLAUDE_SETTINGS_JSON" > /home/developer/.claude/settings.json
    echo '{"hasCompletedOnboarding": true}' > /home/developer/.claude.json
    chown -R developer:developer /home/developer/.claude /home/developer/.claude.json
fi

# Start SSH server
exec /usr/sbin/sshd -D
