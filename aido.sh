QUESTION="$@"

if [[ -z "$QUESTION" ]]; then
  echo "❌ Error: No input detected. Make sure to wrap your prompt in quotes:"
  echo "   Example: ~/asktheory \"Design a DFA that accepts strings...\""
  exit 1
fi

MODEL_NAME="gpt-4o"
if [[ "$QUESTION" == *"image"* || "$QUESTION" == *"draw"* ]]; then
  MODEL_NAME="gpt-image-1"
fi

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
VAULT_PATH="$HOME/Documents/Obsidian/New Remote Snake Pit"
FILENAME="theory-$TIMESTAMP.md"
FULL_PATH="$VAULT_PATH/$FILENAME"

JSON_PAYLOAD=$(jq -n \
  --arg model "$MODEL_NAME" \
  --arg sys "You are a Theory of Computation tutor. Structure answers like this:\\n- Title\\n- Intro sentence\\n- Problem statement\\n- Step-by-step solution\\n- Optional Mermaid diagram if appropriate" \
  --arg usr "$QUESTION" \
  '{
    model: $model,
    messages: [
      {role: "system", content: $sys},
      {role: "user", content: $usr}
    ]
  }')

RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD")

# Create vault directory if it doesn't exist
mkdir -p "$VAULT_PATH"
# Extract content and verify it's not null
CONTENT=$(jq -r '.choices[0].message.content' <<<"$RESPONSE")
if [[ -z "$CONTENT" || "$CONTENT" == "null" ]]; then
  echo "❌ Chat output was null. Check raw response saved to ~/asktheory-debug.json"
  echo "$RESPONSE" > ~/asktheory-debug.json
  exit 1
fi

if echo "$RESPONSE" | grep -q "server_error"; then
  echo "❌ OpenAI server error. Try again shortly."
  echo "$RESPONSE" > ~/asktheory-debug.json
  exit 1
fi

# Write verified content to file
echo "$CONTENT" > "$FULL_PATH"
echo "" >> "$FULL_PATH"

# Fix common malformed LaTeX environments
sed -i '' 's/egin{/\\begin{/g' "$FULL_PATH"
sed -i '' 's/nd{/\\end{/g' "$FULL_PATH"

