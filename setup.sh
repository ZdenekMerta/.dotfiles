#!/usr/bin/env bash

set -o errexit

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

info "####### dotfiles #######"
read -p "Press enter to start:"

install_xcode