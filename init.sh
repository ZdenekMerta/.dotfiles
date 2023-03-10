#!/usr/bin/env bash

set -o errexit

REPOSITORY_URL=https://github.com/ZdenekMerta/.dotfiles.git
REPOSITORY_PATH="$HOME/.dotfiles"

reset_color=$(tput sgr 0)

info() {
  printf "%s[*] %s%s\n" "$(tput setaf 4)" "$1" "$reset_color"
}

warn() {
  printf "%s[*] %s%s\n" "$(tput setaf 3)" "$1" "$reset_color"
}

install_xcode() {
  if xcode-select -p > /dev/null; then
    warn "Xcode Command Line Tools already installed"
  else
    info "Installing Xcode Command Line Tools"
    xcode-select --install
    sudo xcodebuild -license accept
  fi
}

install_homebrew() {
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  if hash brew &>/dev/null; then
    warn "Homebrew already installed"
  else
    info "Installing Homebrew"

    # Reset `sudo` timeout to use Homebrew install in noninteractive mode
    sudo --validate

    # Install Homebrew
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Turn off Homebrew analytics
    brew analytics off
  fi
}

install_git() {
  info "Installing Git"
  brew install git
}

clone_dotfiles_repository() {
  info "Cloning .dotfiles repository '$REPOSITORY_URL' into '$REPOSITORY_PATH'"
  git clone "$REPOSITORY_URL" "$REPOSITORY_PATH"
}

setup() {
  info "Running setup"
  cd "$REPOSITORY_PATH/setup" >/dev/null
  ./setup.sh
}

info "####### dotfiles #######"
read -p "Press enter to start:"

install_xcode
install_homebrew
install_git

clone_dotfiles_repository

setup