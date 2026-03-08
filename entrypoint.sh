#!/bin/bash

if [ -n "$CLAUDE_SETTINGS_JSON" ]; then
    echo "$CLAUDE_SETTINGS_JSON" > /home/developer/.claude/settings.json
fi

exec su developer -c "happy-coder"
