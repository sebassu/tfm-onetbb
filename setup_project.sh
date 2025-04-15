#!/usr/bin/env bash
set -e

echo "Cloning latest version of parsec-benchmark repository..."
TARGET_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$TARGET_DIRECTORY"
git clone https://github.com/cirosantilli/parsec-benchmark.git && cd parsec-benchmark

if command -v module &>/dev/null && module load cesga/system; then
    echo "Loaded FinisTerrae III module"
    ./get-inputs
elif command -v sudo &>/dev/null; then
    echo "Executing PARSEC original setup script..."
    ./configure
else
    echo "Assuming running in a container -> Skipping dependency installation"
    ./get-inputs
fi
