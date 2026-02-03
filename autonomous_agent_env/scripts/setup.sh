#!/bin/bash
set -e

echo ">>> Installing OpenCode..."
curl -fsSL https://opencode.ai/install | bash

echo ">>> Configuring Antigravity Auth and Models..."

# 1. Create the Antigravity provider config content in a temp file
cat <<EOF > /tmp/antigravity_provider.json
{
  "google": {
    "models": {
      "antigravity-gemini-3-pro": {
        "name": "Gemini 3 Pro (Antigravity)",
        "limit": { "context": 1048576, "output": 65535 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
        "variants": {
          "low": { "thinkingLevel": "low" },
          "high": { "thinkingLevel": "high" }
        }
      },
      "antigravity-gemini-3-flash": {
        "name": "Gemini 3 Flash (Antigravity)",
        "limit": { "context": 1048576, "output": 65536 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
        "variants": {
          "minimal": { "thinkingLevel": "minimal" },
          "low": { "thinkingLevel": "low" },
          "medium": { "thinkingLevel": "medium" },
          "high": { "thinkingLevel": "high" }
        }
      },
      "antigravity-claude-sonnet-4-5": {
        "name": "Claude Sonnet 4.5 (Antigravity)",
        "limit": { "context": 200000, "output": 64000 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
      },
      "antigravity-claude-sonnet-4-5-thinking": {
        "name": "Claude Sonnet 4.5 Thinking (Antigravity)",
        "limit": { "context": 200000, "output": 64000 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
        "variants": {
          "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
          "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
        }
      },
      "antigravity-claude-opus-4-5-thinking": {
        "name": "Claude Opus 4.5 Thinking (Antigravity)",
        "limit": { "context": 200000, "output": 64000 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
        "variants": {
          "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
          "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
        }
      },
      "gemini-2.5-flash": {
        "name": "Gemini 2.5 Flash (Gemini CLI)",
        "limit": { "context": 1048576, "output": 65536 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
      },
      "gemini-2.5-pro": {
        "name": "Gemini 2.5 Pro (Gemini CLI)",
        "limit": { "context": 1048576, "output": 65536 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
      },
      "gemini-3-flash-preview": {
        "name": "Gemini 3 Flash Preview (Gemini CLI)",
        "limit": { "context": 1048576, "output": 65536 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
      },
      "gemini-3-pro-preview": {
        "name": "Gemini 3 Pro Preview (Gemini CLI)",
        "limit": { "context": 1048576, "output": 65535 },
        "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
      }
    }
  }
}
EOF

# 2. Update ~/.config/opencode/opencode.json
# - Add "opencode-antigravity-auth@latest" to plugins if not present
# - Merge the provider config
CONFIG_FILE=~/.config/opencode/opencode.json

if [ ! -f "$CONFIG_FILE" ]; then
    echo "{}" > "$CONFIG_FILE"
fi

tmp=$(mktemp)
jq -s '.[0] * {
  plugin: ((.[0].plugin // []) + ["opencode-antigravity-auth@latest"] | unique),
  provider: .[1]
}' "$CONFIG_FILE" /tmp/antigravity_provider.json > "$tmp" && mv "$tmp" "$CONFIG_FILE"

echo ">>> Creating ~/.config/opencode/antigravity.json..."
cat <<EOF > ~/.config/opencode/antigravity.json
{
  "\$schema": "https://raw.githubusercontent.com/NoeFabris/opencode-antigravity-auth/main/assets/antigravity.schema.json",
  "account_selection_strategy": "round-robin",
  "switch_on_first_rate_limit": true,
  "pid_offset_enabled": true,
  "switch_on_error": true
}
EOF

echo ">>> Setup complete."
