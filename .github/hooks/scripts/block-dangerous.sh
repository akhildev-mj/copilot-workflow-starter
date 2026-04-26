#!/bin/bash
set -euo pipefail

# Example security hook script for PreToolUse.
# Blocks obviously dangerous terminal commands.

INPUT="$(cat)"
TOOL_NAME="$(echo "$INPUT" | jq -r '.tool_name // empty')"
TOOL_INPUT="$(echo "$INPUT" | jq -c '.tool_input // {}')"

if [ "$TOOL_NAME" = "runTerminalCommand" ]; then
  COMMAND="$(echo "$TOOL_INPUT" | jq -r '.command // empty')"

  BLOCKLIST='(rm\s+-rf\s+/|git\s+push\s+.*--force|DROP\s+TABLE|:(){:|:&};:|mkfs\.)'

  if echo "$COMMAND" | grep -qiE "$BLOCKLIST"; then
    cat <<EOF
{
  "hookSpecificOutput": {
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked potentially destructive command by workspace hook policy."
  }
}
EOF
    exit 0
  fi
fi

echo '{"continue":true}'
