#!/bin/bash
set -euo pipefail

# Template hook script
# Input is JSON from stdin.

INPUT="$(cat)"

# Example: read event data
TOOL_NAME="$(echo "$INPUT" | jq -r '.tool_name // empty')"

# Keep default behavior permissive unless this script enforces a policy.
echo '{"continue":true}'
