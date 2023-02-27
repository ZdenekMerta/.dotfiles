#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. ./utils.sh
. ./software.sh

info "Installing software"
install_software

success "Done"