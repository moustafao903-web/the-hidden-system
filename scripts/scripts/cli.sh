#!/usr/bin/env bash
set -e

MANUSCRIPT="manuscript/draft.docx"
OUT_DIR="build"
EVENTS="events/events.md"
TITLE=$(cat book-info/book-title.txt 2>/dev/null || echo "Untitled")

mkdir -p "$OUT_DIR"
echo "Running AI generation..."
chmod +x scripts/ai_generate.sh
./scripts/ai_generate.sh

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "- [$TIMESTAMP] cli: ran ai_generate for \"$TITLE\"" >> "$EVENTS"
echo "CLI complete. Check prompts/results.md and events/events.md"
