#!/bin/bash
# Copy this checkout into the Omarchy user theme directory and apply it.
# Re-run after editing; `omarchy theme set` re-reads the files.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$HOME/.config/omarchy/themes/us-army"

mkdir -p "$dest/backgrounds"
cp "$src/colors.toml" "$src/icons.theme" "$src/README.md" "$dest/"
cp "$src/backgrounds/"*.png "$dest/backgrounds/"
cp "$src/preview.png" "$dest/" 2>/dev/null || true

echo "Installed to $dest"
if [[ "${1:-}" == "--apply" ]]; then
  omarchy theme set us-army
fi
