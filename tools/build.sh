#!/usr/bin/env bash
# Compile C++20 host tools using common-elf-reader.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE/.."

echo "=== Building C++20 elf2json host tool ==="
g++ -std=c++20 tools/elf2json.cpp src/elf-image.cpp \
    -Iinclude \
    -o tools/elf2json
echo "=== Done: tools/elf2json ==="

echo ""
echo "Usage:"
echo "  ./tools/elf2json <input.elf> [output.json]   # export ELF for AetherELF GUI"
