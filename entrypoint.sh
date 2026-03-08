#!/bin/bash

if [ -n "$CLAUDE_SETTINGS_JSON" ]; then
    echo "$CLAUDE_SETTINGS_JSON" > /home/developer/.claude/settings.json
fi

# Allocate PTY for happy (Ink requires raw mode)
exec su developer -c "script -q -c happy /dev/null"
