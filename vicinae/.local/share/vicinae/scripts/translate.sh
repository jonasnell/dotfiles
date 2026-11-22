#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Translate
# @vicinae.packageName (DE-EN)
# @vicinae.mode fullOutput
# @vicinae.icon 🌐
# @vicinae.argument1 { "type": "text", "placeholder": "Text in English or German..." }

INPUT=$(printf '%b' "$1")
CODE=$(trans -id -no-ansi "$INPUT" 2>/dev/null | awk '/^Code/ {print $2}')

if [ "$CODE" = "de" ]; then
  SRC="de"; TGT="en"; SRC_NAME="German"; TGT_NAME="English"
else
  SRC="en"; TGT="de"; SRC_NAME="English"; TGT_NAME="German"
fi

RESULT=$(trans -b -no-ansi "${SRC}:${TGT}" "$INPUT" 2>/dev/null)
[ -z "$RESULT" ] && echo "Translation failed." && exit 1

echo "$TGT_NAME:"
echo "$RESULT"
echo ""
echo "$SRC_NAME:"
echo "$INPUT"

