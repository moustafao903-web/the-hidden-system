#!/usr/bin/env bash
set -e
TITLE_FILE="book-info/book-title.txt"
DESC_FILE="book-info/description.txt"
OUT="prompts/results.md"
EVENTS="events/events.md"
API_KEY="${OPENAI_API_KEY:-}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: set OPENAI_API_KEY environment variable or GitHub secret"
  exit 1
fi

TITLE=$(cat "$TITLE_FILE" 2>/dev/null || echo "Untitled")
DESC=$(cat "$DESC_FILE" 2>/dev/null || echo "")

PROMPT="You are a professional book marketer. Given the title: \"$TITLE\" and description: \"$DESC\" generate:
1) Five alternative short titles.
2) For each title, three subtitle options.
3) Three marketing descriptions: 150 words, 100 words, 50 words.
4) Ten keywords suitable for KDP.
Return output in plain text with clear headings."

RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{\"model\":\"gpt-4o-mini\",\"messages\":[{\"role\":\"user\",\"content\":\"$PROMPT\"}],\"max_tokens\":800}")

CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content' 2>/dev/null || echo "AI response parsing failed")

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
mkdir -p prompts events
echo "## Generated AI Results - $TIMESTAMP" >> "$OUT"
echo "" >> "$OUT"
echo "$CONTENT" >> "$OUT"
echo "" >> "$OUT"
echo "- [$TIMESTAMP] AI generate: results appended to $OUT" >> "$EVENTS"
echo "AI generation complete. Results in $OUT"
