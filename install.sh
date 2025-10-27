#!/bin/bash

# ==============================================================================
# Installation Script for React Native Project Creation MCP
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

print_header() {
  echo ""
  echo -e "${CYAN}${BOLD}╔════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}${BOLD}║                                                            ║${NC}"
  echo -e "${CYAN}${BOLD}║     React Native Project Creation MCP - Installer         ║${NC}"
  echo -e "${CYAN}${BOLD}║                                                            ║${NC}"
  echo -e "${CYAN}${BOLD}╚════════════════════════════════════════════════════════════╝${NC}"
  echo ""
}

print_step() {
  echo -e "${CYAN}➡️  $1${NC}"
}

print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
  echo -e "${RED}❌ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

check_prerequisites() {
  print_step "Checking prerequisites..."

  local missing_tools=()
  local warnings=()

  # Check required tools
  if ! command -v gh &> /dev/null; then
    missing_tools+=("gh (GitHub CLI)")
  fi

  if ! command -v git &> /dev/null; then
    missing_tools+=("git")
  fi

  if ! command -v npx &> /dev/null; then
    missing_tools+=("npx (Node.js)")
  fi

  # Check optional tools
  if ! command -v pod &> /dev/null; then
    warnings+=("CocoaPods (required for iOS development)")
  fi

  if [ ${#missing_tools[@]} -gt 0 ]; then
    print_error "Missing required tools:"
    for tool in "${missing_tools[@]}"; do
      echo "  - $tool"
    done
    echo ""
    echo "Installation commands:"
    echo "  brew install node       # Installs Node.js (includes npx)"
    echo "  brew install git        # Installs Git"
    echo "  brew install gh         # Installs GitHub CLI"
    echo "  gh auth login           # Authenticate with GitHub"
    echo ""
    exit 1
  fi

  if [ ${#warnings[@]} -gt 0 ]; then
    print_warning "Optional tools missing (install later if needed):"
    for tool in "${warnings[@]}"; do
      echo "  - $tool"
    done
    echo ""
    echo "Optional installation:"
    echo "  sudo gem install cocoapods"
    echo ""
  fi

  print_success "All required tools are installed!"
}

install_script() {
  print_step "Installing create-rn-app command..."

  # Check if script exists in current directory
  if [ ! -f "create-rn-app" ]; then
    print_error "create-rn-app script not found in current directory."
    echo "Please run this installer from the create-rn-app-mcp directory."
    exit 1
  fi

  # Copy to /usr/local/bin
  sudo cp create-rn-app /usr/local/bin/
  sudo chmod +x /usr/local/bin/create-rn-app

  print_success "Command installed to /usr/local/bin/create-rn-app"
}

verify_installation() {
  print_step "Verifying installation..."

  if command -v create-rn-app &> /dev/null; then
    print_success "Installation verified! Command is available."
  else
    print_error "Installation verification failed."
    echo ""
    echo "You may need to:"
    echo "  1. Restart your terminal"
    echo "  2. Add /usr/local/bin to your PATH"
    exit 1
  fi
}

configure_dev_directory() {
  echo ""
  echo -e "${BOLD}Configuration:${NC}"
  echo ""
  echo "The default project directory is: /Users/nate/Documents/development"
  echo ""
  read -p "Do you want to change this? (y/n): " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    read -p "Enter your preferred development directory (absolute path): " NEW_DIR

    # Update the script
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS
      sudo sed -i '' "s|DEV_DIR=\"/Users/nate/Documents/development\"|DEV_DIR=\"$NEW_DIR\"|g" /usr/local/bin/create-rn-app
    else
      # Linux
      sudo sed -i "s|DEV_DIR=\"/Users/nate/Documents/development\"|DEV_DIR=\"$NEW_DIR\"|g" /usr/local/bin/create-rn-app
    fi

    print_success "Development directory updated to: $NEW_DIR"
  fi
}

print_final_message() {
  echo ""
  echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}${BOLD}║                                                            ║${NC}"
  echo -e "${GREEN}${BOLD}║            ✅ Installation Complete! ✅                    ║${NC}"
  echo -e "${GREEN}${BOLD}║                                                            ║${NC}"
  echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${BOLD}You can now create React Native projects with:${NC}"
  echo ""
  echo "  create-rn-app \"Your Project Name\""
  echo ""
  echo -e "${BOLD}Next steps:${NC}"
  echo ""
  echo "  1. Restart your terminal (or run: source ~/.zshrc)"
  echo "  2. Try creating your first project!"
  echo "  3. Read the README.md for full documentation"
  echo ""
  echo -e "${CYAN}Happy coding! 🎉${NC}"
  echo ""
}

# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

main() {
  print_header
  check_prerequisites
  install_script
  configure_dev_directory
  verify_installation
  print_final_message
}

main
