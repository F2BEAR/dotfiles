#!/bin/bash
set -e
set -u

echo "⚙  Starting base installations"

# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "📦 Installing packages..."
sudo apt update
sudo apt install -y git zsh curl build-essential make unzip wslu

# Homebrew installation
if ! command_exists brew; then
  echo "🍺 Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >>"$HOME/.zprofile"
  elif [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
    echo "eval \"\$($HOME/.linuxbrew/bin/brew shellenv)\"" >>"$HOME/.zprofile"
  else
    echo "⚠️  Cannot find Homebrew installation path. You may need to add Homebrew to your PATH manually."
  fi
else
  echo "✅ Homebrew is already installed."
fi

# ZSH setup
if [[ "$SHELL" != *zsh ]]; then
  echo "🐚 Switching to zsh..."
  chsh -s "$(which zsh)"
  echo "⚠️  You might need to log out and back in for shell change to take effect."
fi

# Dotfiles setup
DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "🔗 Cloning dotfiles..."
  git clone https://github.com/F2BEAR/dotfiles.git "$DOTFILES_DIR"
else
  echo "✅ Dotfiles already cloned."
  echo "🔄 Updating dotfiles..."
  (cd "$DOTFILES_DIR" && git pull)
fi

# Install Homebrew packages
echo "🍻 Installing Homebrew packages..."
brew install go bat eza git-delta starship zoxide stow neovim fd thefuck fzf jq nvm zsh-autosuggestions zsh-syntax-highlighting

# Node.js installation
echo "📦 Installing Node.js (LTS)..."
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
if [[ -s "$(brew --prefix nvm)/nvm.sh" ]]; then
  . "$(brew --prefix nvm)/nvm.sh"
  nvm install --lts
  nvm alias default lts/*
else
  echo "⚠️  NVM installation not found. Please install NVM manually."
fi

# Docker installation
echo "🐳 Installing Docker and Docker Compose..."
if ! command_exists docker; then
  # Install prerequisites
  sudo apt install -y ca-certificates curl gnupg lsb-release

  # Set up Docker repository
  if [[ ! -f /etc/apt/keyrings/docker.gpg ]]; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt update
  fi

  # Install Docker packages
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "🧼 Adding user to the docker group..."
  sudo usermod -aG docker "$USER"
  echo "⚠️  You'll need to log out and back in for Docker permissions to take effect."

  # WSL 2 specific Docker setup
  echo "🐳 Setting up Docker for WSL 2..."
  if ! grep -q "WSL_HOST_IP" "$HOME/.zprofile"; then
    echo '# Get WSL host IP for Docker' >>"$HOME/.zprofile"
    echo 'export WSL_HOST_IP=$(grep nameserver /etc/resolv.conf | cut -d " " -f2)' >>"$HOME/.zprofile"
  fi
else
  echo "✅ Docker is already installed."
fi

# Font installation
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"
NERD_FONT_ZIP="JetBrainsMono.zip"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$NERD_FONT_ZIP"

if [[ ! -d "$FONT_DIR/$FONT_NAME" ]]; then
  echo "📦 Downloading JetBrains Mono Nerd Font..."
  mkdir -p "$FONT_DIR"
  cd /tmp
  curl -fLo "$NERD_FONT_ZIP" --progress-bar "$NERD_FONT_URL"

  echo "📁 Extracting fonts..."
  unzip -qo "$NERD_FONT_ZIP" -d "$FONT_DIR/$FONT_NAME"

  echo "🧹 Cleaning up..."
  rm -f "/tmp/$NERD_FONT_ZIP"

  echo "🔄 Rebuilding font cache..."
  fc-cache -fv "$FONT_DIR"
  echo "✅ JetBrains Mono Nerd Font installed at $FONT_DIR/$FONT_NAME"
else
  echo "✅ JetBrains Mono Nerd Font already installed."
fi

# Copy configuration files
echo "🗂️ Copying custom files to /etc..."
if [[ -d "$DOTFILES_DIR/etc" ]]; then
  if [[ -f "$DOTFILES_DIR/etc/wsl.conf" && -f "$DOTFILES_DIR/etc/resolv.conf" ]]; then
    if [ "$EUID" -ne 0 ]; then
      echo "🔐 Using sudo to copy files to /etc"
      sudo cp "$DOTFILES_DIR/etc/wsl.conf" /etc/wsl.conf
      sudo cp "$DOTFILES_DIR/etc/resolv.conf" /etc/resolv.conf
    else
      cp "$DOTFILES_DIR/etc/wsl.conf" /etc/wsl.conf
      cp "$DOTFILES_DIR/etc/resolv.conf" /etc/resolv.conf
    fi
    echo "✅ Configuration files copied successfully."
  else
    echo "⚠️  Required config files not found in $DOTFILES_DIR/etc/"
  fi
else
  echo "⚠️  Dotfiles etc/ directory not found. Skipping configuration files."
fi

# Run the Makefile for wezterm config
echo "🖥️  Setting up wezterm configuration..."
if [[ -f "$DOTFILES_DIR/Makefile" ]]; then
  echo "🔧 Running Makefile to install wezterm config to Windows user directory..."
  (cd "$DOTFILES_DIR" && make)
  if [ $? -eq 0 ]; then
    echo "✅ Wezterm configuration installed successfully."
  else
    echo "⚠️  Error running Makefile for wezterm configuration."
  fi
else
  echo "⚠️  Makefile not found in $DOTFILES_DIR. Wezterm configuration not installed."
fi

# Stow dotfiles if available
if [[ -d "$DOTFILES_DIR" ]]; then
  echo "🔗 Linking dotfiles with stow..."
  cd "$DOTFILES_DIR"
  # Assuming standard stow directory structure
  for dir in */; do
    dir=${dir%/} # Remove trailing slash
    # Skip certain directories that should not be stowed
    if [[ "$dir" != "etc" && "$dir" != ".git" ]]; then
      echo "🔄 Stowing $dir..."
      stow -v "$dir" || echo "⚠️  Failed to stow $dir"
    fi
  done
fi

# WSL-specific optimizations
echo "🐧 Applying WSL 2 optimizations..."

# Configure WSL memory limits if not already set
if ! grep -q "memory" /etc/wsl.conf 2>/dev/null; then
  echo "🔧 Setting WSL 2 memory limits..."
  cat <<EOF | sudo tee -a /etc/wsl.conf >/dev/null
[wsl2]
memory=8GB
processors=4
swap=2GB
EOF
fi

echo "✅ Base installation completed."
echo "🔄 To apply all changes, please restart your terminal or run: exec zsh"
echo "⚠️  Some changes like Docker permissions will require you to restart WSL with 'wsl --shutdown' from PowerShell."
