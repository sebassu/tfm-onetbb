#!/usr/bin/env bash
set -e

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Installing required dependencies for MacOS..."
    if ! command -v brew &>/dev/null; then
        echo "🍺 Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    brew install cmake m4 tbb
    brew install --cask xquartz
    if ! xcode-select -p &>/dev/null; then
        echo "Xcode command line tools not found. Installing..."
        xcode-select --install
    fi
fi

TARGET_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$TARGET_DIRECTORY"
git clone https://github.com/cirosantilli/parsec-benchmark.git
