#!/bin/bash

set -euo pipefail

# download uses curl to download a teleport binary
download() {
  URL=$1
  TMP_PATH=$2

  echo "Downloading $URL"
  set -x
  $SUDO $CURL -o "$TMP_PATH" "$URL"
  set +x
}

# if teleport is already installed, exit
is_teleport_installed() {
  if type /opt/bin/teleport &>/dev/null; then
    GREEN='\033[0;32m'
    COLOR_OFF='\033[0m'

    echo ""
    echo -e "${GREEN}$(teleport version) installed successfully!${COLOR_OFF}"
    echo ""
    return 0
  fi
  return 1
}

# downloads teleport binary tarball, verifies its checksum, and installs
install_via_curl() {
  TEMP_DIR=$(mktemp -d -t teleport-XXXXXXXXXX)
  trap "rm -rf $TEMP_DIR" EXIT

  INSTALL_DIR=/opt/bin
  mkdir -vp $INSTALL_DIR

  TELEPORT_FILENAME="teleport-v${TELEPORT_VERSION}-linux-${ARCH}-bin.tar.gz"
  URL="https://get.gravitational.com/${TELEPORT_FILENAME}"
  download "${URL}" "${TEMP_DIR}/${TELEPORT_FILENAME}"

  TMP_CHECKSUM="${TEMP_DIR}/${TELEPORT_FILENAME}.sha256"
  download "${URL}.sha256" "$TMP_CHECKSUM"

  set -x
  cd "$TEMP_DIR"
  $SUDO $SHA_COMMAND -c "$TMP_CHECKSUM"
  cd -

  $SUDO tar -xzf "${TEMP_DIR}/${TELEPORT_FILENAME}" -C "$TEMP_DIR"
  $SUDO install -m 755 "${TEMP_DIR}/teleport/teleport" "${INSTALL_DIR}/teleport"
  set +x
}

# install teleport if it's not already installed
install_teleport() {
  if [[ $(uname) != "Linux" ]]; then
    echo "ERROR: This script works only for Linux."
    exit 1
  fi

  KERNEL_VERSION=$(uname -r)
  MIN_VERSION="2.6.23"
  if [ $MIN_VERSION != $(echo -e "$MIN_VERSION\n$KERNEL_VERSION" | sort -V | head -n1) ]; then
    echo "ERROR: Teleport requires Linux kernel version $MIN_VERSION+"
    exit 1
  fi

  # having 'sudo' installed
  IS_ROOT=""
  SUDO=""
  if [ "$(id -u)" = 0 ]; then
    # running as root, no need for sudo/doas
    IS_ROOT="YES"
    SUDO=""
  elif type sudo &>/dev/null; then
    SUDO="sudo"
  fi

  # require root
  if [ -z "$SUDO" ] && [ -z "$IS_ROOT" ]; then
    echo "ERROR:  The installer requires a way to run commands as root."
    echo "Either run this script as root or install sudo"
    exit 1
  fi

  # require curl
  CURL=""
  if type curl &>/dev/null; then
    CURL="curl -fL"
  else
    echo "ERROR: This script requires curl in order to download files. Please install one of them and try again."
    exit 1
  fi

  # require shasum/sha256sum
  SHA_COMMAND=""
  if type sha256sum &>/dev/null; then
    SHA_COMMAND="sha256sum"
  else
    echo "ERROR: This script requires sha256sum to validate the download. Please install it and try again."
    exit 1
  fi

  # detect architecture
  ARCH=""
  case $(uname -m) in
  x86_64)
    ARCH="amd64"
    ;;
  **)
    echo "ERROR: Your system's architecture isn't officially supported or couldn't be determined."
    ;;
  esac

  install_via_curl
  is_teleport_installed
}

if [ $# -ge 1 ] && [ -n "$1" ]; then
  TELEPORT_VERSION=$1
else
  echo "ERROR: Please provide the version you want to install (e.g., 10.1.9)."
  exit 1
fi
is_teleport_installed || install_teleport
