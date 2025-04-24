#!/bin/bash

set -e
set -u

echo "⚙  Starting base installations"

echo "📦 Installing packages..."
sudo apt update
sudo apt install -y git zsh curl build-essential

if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>"$HOME/.zprofile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  echo "✅ Homebrew is already installed."
fi

if [[ "$SHELL" != *zsh ]]; then
  echo "🐚 switching to zsh..."
  chsh -s "$(which zsh)"
fi

DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "🔗 Clonning dotfiles..."
  git clone https://github.com/F2BEAR/dotfiles.git "$DOTFILES_DIR"
fi

echo "🍻 Installing Homebrew packages..."
brew install bat eza git-delta starship zoxide stow neovim fd thefuck fzf jq nvm zsh-autosuggestions zsh-syntax-highlighting

echo "🐳 Installing Docker and Docker Compose..."
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🧼 Adding user to the docker group..."
sudo usermod -aG docker "$USER"

FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"
NERD_FONT_ZIP="JetBrainsMono.zip"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$NERD_FONT_ZIP"

echo "📦 Downloading JetBrains Mono Nerd Font..."
mkdir -p "$FONT_DIR"
cd /tmp
curl -fLo "$NERD_FONT_ZIP" --progress-bar "$NERD_FONT_URL"

echo "📁 Extracting fonts..."
unzip -qo "$NERD_FONT_ZIP" -d "$FONT_DIR/$FONT_NAME"

echo "🔄 Rebuilding font cache..."
fc-cache -fv "$FONT_DIR"

echo "✅ JetBrains Mono Nerd Font installed at $FONT_DIR/$FONT_NAME"

echo "🗂️ Copiando archivos personalizados a /etc..."

if [ "$EUID" -ne 0 ]; then
  echo "🔐 You need sudo to copy to /etc"
  sudo cp etc/wsl.conf /etc/wsl.conf
  sudo cp etc/resolv.conf /etc/resolv.conf
else
  cp etc/wsl.conf /etc/wsl.conf
  cp etc/resolv.conf /etc/resolv.conf
fi

echo "✅ Base installation completed."
echo "Reboot the shell or run 'zsh' now."
