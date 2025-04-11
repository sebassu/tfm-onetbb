#!/usr/bin/env bash
set -e

setup_macos() {
    brew install cmake m4 tbb wget gnu-tar
    brew install --cask xquartz
    if ! xcode-select -p &>/dev/null; then
        echo "Xcode command line tools not found. Installing..."
        xcode-select --install
    fi
    export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
    ./get-inputs
}

echo "Cloning latest version of parsec-benchmark repository..."
TARGET_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$TARGET_DIRECTORY"
git clone https://github.com/cirosantilli/parsec-benchmark.git && cd parsec-benchmark

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Installing required dependencies for MacOS..."
    setup_macos
else
    echo "Assuming FinisTerrae III..."
    if ! command -v module &>/dev/null || ! module load cesga/system; then
        echo "Defaulting to original setup script"
        ./configure
    else
        ./get-inputs
    fi
fi
