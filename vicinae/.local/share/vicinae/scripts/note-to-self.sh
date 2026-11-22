#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Notes
# @vicinae.packageName Telegram
# @vicinae.description Send a note to your Telegram chat
# @vicinae.mode compact
# @vicinae.icon 🗒️
# @vicinae.argument1 { "type": "text", "placeholder": "Write a note..." }

# Source secrets.env to get BOT_TOKEN and CHAT_ID
SECRETS_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/vicinae/secrets.env"
if [ ! -f "$SECRETS_FILE" ]; then
  echo "Missing $SECRETS_FILE"
  exit 1
fi
source "$SECRETS_FILE"

MESSAGE=$(printf '%b' "$1")

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  --data-urlencode "chat_id=${CHAT_ID}" \
  --data-urlencode "text=${MESSAGE}")

if echo "$RESPONSE" | grep -q '"ok":true'; then
  echo "Note sent"
else
  echo "Failed to send note"
  exit 1
fi

