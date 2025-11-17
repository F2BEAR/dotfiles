#!/bin/bash
# Git Credential Manager setup with Bitwarden
set -e

echo "🔐 Setting up Git Credential Manager with Bitwarden..."

# Check if Bitwarden CLI is installed
if ! command -v bw >/dev/null 2>&1; then
  echo "❌ Bitwarden CLI is not installed. Please install it first."
  exit 1
fi

# Check if Bitwarden session is unlocked
if ! bw status | grep -q '"status":"unlocked"'; then
  echo "🔓 Bitwarden vault is locked. Please unlock it first:"
  echo "   Run: export BW_SESSION=\$(bw unlock --raw)"
  exit 1
fi

# Retrieve GitHub token from Bitwarden
echo "🔍 Retrieving GitHub Access Token from Bitwarden..."
GITHUB_TOKEN=$(bw get notes "GitHub Access Token" 2>/dev/null)

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "❌ Could not retrieve 'GitHub Access Token' from Bitwarden."
  echo "   Make sure the secure note exists and is named exactly 'GitHub Access Token'"
  exit 1
fi

# Configure Git Credential Manager
echo "⚙️  Configuring Git to use credential helper..."
git config --global credential.helper store

# Store the GitHub credential
echo "💾 Storing GitHub credentials..."
cat <<EOF > ~/.git-credentials
https://$(git config --global user.name | tr ' ' '-'):${GITHUB_TOKEN}@github.com
EOF

# Secure the credentials file
chmod 600 ~/.git-credentials

echo "✅ Git Credential Manager configured successfully!"
echo "🔒 Your GitHub token is now stored securely in ~/.git-credentials"
echo ""
echo "You can now use Git with GitHub without entering your password."
