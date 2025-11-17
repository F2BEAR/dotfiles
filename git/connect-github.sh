#!/bin/bash
# Connect GitHub with Git Credential Manager via Bitwarden
set -e

echo "🔐 Connecting GitHub with Git Credential Manager..."

# Check if Git Credential Manager is installed
if ! command -v git-credential-manager >/dev/null 2>&1; then
  echo "❌ Git Credential Manager is not installed."
  echo "   Install it with: brew install git-credential-manager"
  exit 1
fi

# Check if Bitwarden CLI is installed
if ! command -v bw >/dev/null 2>&1; then
  echo "❌ Bitwarden CLI is not installed."
  echo "   Install it with: brew install bitwarden-cli"
  exit 1
fi

# Check Bitwarden session status
BW_STATUS=$(bw status | jq -r '.status')

if [[ "$BW_STATUS" == "locked" ]]; then
  echo "🔓 Unlocking Bitwarden vault..."
  echo "   Please enter your master password:"
  export BW_SESSION=$(bw unlock --raw)
  if [[ -z "$BW_SESSION" ]]; then
    echo "❌ Failed to unlock Bitwarden vault."
    exit 1
  fi
  echo "✅ Bitwarden vault unlocked."
elif [[ "$BW_STATUS" == "unauthenticated" ]]; then
  echo "❌ Bitwarden is not authenticated. Please login first:"
  echo "   Run: bw login"
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
echo "⚙️  Configuring Git Credential Manager..."
git config --global credential.helper manager
git config --global credential.credentialStore secretservice

# Test GitHub connection
echo "🧪 Testing GitHub connection..."
echo "   This will store your credentials in Git Credential Manager."
echo ""

# Create a temporary credentials file for git-credential-manager
GCM_INPUT=$(cat <<EOF
protocol=https
host=github.com
username=$(git config --global user.name | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
password=${GITHUB_TOKEN}
EOF
)

# Store credentials using git-credential-manager
echo "$GCM_INPUT" | git credential approve

echo ""
echo "✅ Git Credential Manager configured successfully!"
echo "🔒 Your GitHub credentials are now managed by Git Credential Manager."
echo ""
echo "Test it by running: git ls-remote https://github.com/F2BEAR/dotfiles.git"
