#!/bin/bash
# Auto-format changed files using Prettier after agent edits
# Triggered by PostToolUse hook

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')

# Only format after file creation or edit operations
if [ "$TOOL_NAME" = "editFiles" ] || [ "$TOOL_NAME" = "createFile" ]; then
  # Extract file paths from tool input
  FILES=$(echo "$INPUT" | jq -r '.tool_input.files[]? // .tool_input.path // empty')

  if [ -z "$FILES" ]; then
    echo '{"continue":true}'
    exit 0
  fi

  # Format each changed file with Prettier (if installed)
  for FILE in $FILES; do
    if [ -f "$FILE" ]; then
      # Check if prettier is available
      if command -v npx &> /dev/null; then
        npx prettier --write "$FILE" 2>/dev/null
      fi
    fi
  done

  # Return success
  echo '{"continue":true}'
else
  echo '{"continue":true}'
fi
