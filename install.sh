#!/bin/bash

# --- Color definitions for output ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Hezrai's Dotfiles Installation...${NC}\n"

# 1. Install system dependencies via DNF
echo -e "${GREEN}Installing system dependencies...${NC}"
sudo dnf install -y \
  sway foot rofi-wayland swayidle hyprlock fzf zsh \
  util-linux-user git grim slurp wl-clipboard sddm \
  python3-pip python3-devel imagemagick

# 2. Install Pywal (via pip)
echo -e "${GREEN}Installing Pywal...${NC}"
pip3 install --user pywal

# 3. Create project directory structure
echo -e "${GREEN}Creating directory structure...${NC}"
mkdir -p "$HOME/dotfiles/config/hypr/themes/"
mkdir -p "$HOME/dotfiles/config/sddm/themes/"
mkdir -p "$HOME/.config/sway"
mkdir -p "$HOME/.config/foot"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Pictures/wallpapers"

# 4. Install Themes (Clone and cleanup .git)
echo -e "${GREEN}Installing Hyprlock Styles...${NC}"
if [ ! -d "$HOME/dotfiles/config/hypr/themes/Hyprlock-Styles" ]; then
  git clone https://github.com/MrVivekRajan/Hyprlock-Styles "$HOME/dotfiles/config/hypr/themes/Hyprlock-Styles"
  rm -rf "$HOME/dotfiles/config/hypr/themes/Hyprlock-Styles/.git"
fi

echo -e "${GREEN}Installing SDDM Themes (Sugar Candy)...${NC}"
if [ ! -d "$HOME/dotfiles/config/sddm/themes/sddm-sugar-candy" ]; then
  git clone https://github.com/MarianArlt/sddm-sugar-candy "$HOME/dotfiles/config/sddm/themes/sddm-sugar-candy"
  rm -rf "$HOME/dotfiles/config/sddm/themes/sddm-sugar-candy/.git"
fi

# 5. Configure awww-daemon
echo -e "${GREEN}Configuring awww-daemon...${NC}"
# Assuming awww is located in your scripts or local bin directory
if [ -f "./scripts/awww-daemon" ]; then
  chmod +x ./scripts/awww-daemon
  ln -sf "$(pwd)/scripts/awww-daemon" "$HOME/.local/bin/awww-daemon"
fi

# 6. Setup Symbolic Links
DOTFILES_DIR=$(pwd)
echo -e "${GREEN}Creating symbolic links...${NC}"

# Sway & Scripts
ln -sf "$DOTFILES_DIR/sway/config" "$HOME/.config/sway/config"
chmod +x "$DOTFILES_DIR/scripts/"*
ln -sf "$DOTFILES_DIR/scripts/wall-picker.sh" "$HOME/.local/bin/wall-picker.sh"

# Hypr Themes link
mkdir -p "$HOME/.config/hypr"
ln -sf "$DOTFILES_DIR/config/hypr/themes" "$HOME/.config/hypr/themes"

# 7. Shell Configuration & Cleanup
if [ "$SHELL" != "$(which zsh)" ]; then
  echo -e "${GREEN}Changing default shell to Zsh...${NC}"
  chsh -s "$(which zsh)"
fi

echo -e "\n${BLUE}Installation complete!${NC}"
echo -e "Make sure ${GREEN}~/.local/bin${NC} is in your PATH for 'awww-daemon' and 'pywal' to work correctly."
