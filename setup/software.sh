brew_packages=(
  authy
  bat                      # https://github.com/sharkdp/bat
  bandwhich                # https://github.com/imsnif/bandwhich
  bottom                   # https://github.com/ClementTsang/bottom
  camo-studio
  curl
  dust                     # https://github.com/bootandy/dust
  exa                      # https://github.com/ogham/exa
  fish
  fzf                      # https://github.com/junegunn/fzf
  gettext
  git-delta                # https://github.com/dandavison/delta
  helix
  jq
  mas                      # https://github.com/mas-cli/mas
  openssl
  podman
  podman-desktop           # https://podman-desktop.io/
  procs                    # https://github.com/dalance/procs/
  signal
  spotify
  stow
  vlc
  warp
  websocat                 # https://github.com/vi/websocat
  wget
)

appstore_apps=(
  732710998  # Enpass
  441258766  # Magnet
  1529448980 # Reeder 5
)

install_software() {
  info "Installing Homebrew packages"
  for package in "${brew_packages[@]}"; do
    if brew list | grep "$package" > /dev/null; then
      warn "Package $package is already installed"
    else
      info "Installing package < $package >"
      brew install "$package"
    fi
  done

  info "Cleaning up Homebrew packages"
  brew cleanup

  info "Installing App Store applications"
  for app in "${appstore_apps[@]}"; do
    mas install "$app"
  done
}