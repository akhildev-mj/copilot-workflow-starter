#!/bin/bash
# Security hook: Block dangerous commands before they execute
# Triggered by PreToolUse hook

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // {}')

# Only check terminal commands
if [ "$TOOL_NAME" = "runTerminalCommand" ]; then
  COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty')

  # Dangerous patterns to block
  if echo "$COMMAND" | grep -qiE '(rm\s+-rf|rm\s+-r\s+/|DROP\s+TABLE|DELETE\s+FROM.*WHERE|git\s+push.*--force)'; then
    cat <<EOF
{
  "hookSpecificOutput": {
    "permissionDecision": "deny",
    "permissionDecisionReason": "Dangerous command blocked by security policy: $COMMAND"
  }
}
EOF
    exit 0
  fi
fi

# Allow all other operations
echo '{"continue":true}'
