#!/bin/bash
# Grab current REAPER settings into dotfiles
# Run this after making changes in REAPER you want to preserve

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REAPER_DIR="$HOME/Library/Application Support/REAPER"

if [[ ! -d "$REAPER_DIR" ]]; then
    echo "REAPER config folder not found at $REAPER_DIR"
    exit 1
fi

echo "Grabbing REAPER config..."

# Core config files
for file in reaper.ini reaper-kb.ini reaper-mouse.ini reaper-menu.ini reaper-wndpos.ini reaper-fxtags.ini reapack.ini "S&M.ini" "sws-autocoloricon.ini" "BR.ini"; do
    if [[ -f "$REAPER_DIR/$file" ]]; then
        cp "$REAPER_DIR/$file" "$SCRIPT_DIR/$file"
        echo "  ✓ $file"
    fi
done

# Clean machine-specific paths from reaper.ini
if [[ -f "$SCRIPT_DIR/reaper.ini" ]]; then
    # Remove lines with absolute paths that won't exist on other machines
    sed -i '' '/^lastproject=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^lastprojuiref=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^lastmenusetdir=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^lastscript=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^midiexportpath=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^mididefcolormap=/d' "$SCRIPT_DIR/reaper.ini"
    sed -i '' '/^projecttab[0-9]*=/d' "$SCRIPT_DIR/reaper.ini"
    # Clean [Recent] section - remove recent project paths
    sed -i '' '/^recent[0-9]*=/d' "$SCRIPT_DIR/reaper.ini"
    echo "  ✓ reaper.ini (cleaned machine-specific paths)"
fi

# Scripts (sync - clear and copy)
if [[ -d "$REAPER_DIR/Scripts/User" ]] && [[ -n "$(ls -A "$REAPER_DIR/Scripts/User" 2>/dev/null)" ]]; then
    rm -rf "$SCRIPT_DIR/Scripts"
    mkdir -p "$SCRIPT_DIR/Scripts"
    cp -R "$REAPER_DIR/Scripts/User/"* "$SCRIPT_DIR/Scripts/"
    echo "  ✓ Scripts/User/ (synced)"
fi

# Color themes (skip defaults)
if [[ -d "$REAPER_DIR/ColorThemes" ]]; then
    mkdir -p "$SCRIPT_DIR/ColorThemes"
    for f in "$REAPER_DIR/ColorThemes/"*.ReaperTheme*; do
        [[ -f "$f" ]] || continue
        fname=$(basename "$f")
        [[ "$fname" == Default_* ]] && continue
        cp "$f" "$SCRIPT_DIR/ColorThemes/"
    done
    echo "  ✓ ColorThemes/ (custom only)"
fi

# MIDI note names (skip sample file)
if [[ -d "$REAPER_DIR/MIDINoteNames" ]]; then
    mkdir -p "$SCRIPT_DIR/MIDINoteNames"
    for f in "$REAPER_DIR/MIDINoteNames/"*.txt; do
        [[ "$(basename "$f")" == "note_name_sample.txt" ]] && continue
        cp "$f" "$SCRIPT_DIR/MIDINoteNames/"
    done
    echo "  ✓ MIDINoteNames/"
fi

# FX Chains (if any)
if [[ -d "$REAPER_DIR/FXChains" ]] && [[ -n "$(ls -A "$REAPER_DIR/FXChains" 2>/dev/null)" ]]; then
    mkdir -p "$SCRIPT_DIR/FXChains"
    cp -R "$REAPER_DIR/FXChains/"* "$SCRIPT_DIR/FXChains/" 2>/dev/null || true
    echo "  ✓ FXChains/"
fi

# Track templates (if any)
if [[ -d "$REAPER_DIR/TrackTemplates" ]] && [[ -n "$(ls -A "$REAPER_DIR/TrackTemplates" 2>/dev/null)" ]]; then
    mkdir -p "$SCRIPT_DIR/TrackTemplates"
    cp -R "$REAPER_DIR/TrackTemplates/"* "$SCRIPT_DIR/TrackTemplates/" 2>/dev/null || true
    echo "  ✓ TrackTemplates/"
fi

# Project templates (if any)
if [[ -d "$REAPER_DIR/ProjectTemplates" ]] && [[ -n "$(ls -A "$REAPER_DIR/ProjectTemplates" 2>/dev/null)" ]]; then
    mkdir -p "$SCRIPT_DIR/ProjectTemplates"
    cp -R "$REAPER_DIR/ProjectTemplates/"* "$SCRIPT_DIR/ProjectTemplates/" 2>/dev/null || true
    echo "  ✓ ProjectTemplates/"
fi

# Custom toolbar icons (Reapertips color picker etc)
if ls "$REAPER_DIR/Data/toolbar_icons/toolbar_rt_"* 1>/dev/null 2>&1; then
    mkdir -p "$SCRIPT_DIR/Data/toolbar_icons"
    cp "$REAPER_DIR/Data/toolbar_icons/toolbar_rt_"* "$SCRIPT_DIR/Data/toolbar_icons/"
    echo "  ✓ Data/toolbar_icons/ (custom only)"
fi

# ReaPack installed packages list
REAPACK_DB="$REAPER_DIR/ReaPack/registry.db"
if [[ -f "$REAPACK_DB" ]]; then
    cat > "$SCRIPT_DIR/reapack-packages.txt" << 'HEADER'
# Required ReaPack Packages
# Install via: Extensions > ReaPack > Browse packages
# Search for each package name and install

HEADER
    # Extract package names from registry (skip ReaPack itself)
    sqlite3 "$REAPACK_DB" "SELECT printf('%-35s # %s', replace(replace(package,'.lua',''),'.ext',''), desc) FROM entries WHERE package <> 'ReaPack.ext';" >> "$SCRIPT_DIR/reapack-packages.txt" 2>/dev/null
    echo "  ✓ reapack-packages.txt"
fi

echo ""
echo "Done. Config captured in dotfiles."
echo "Don't forget to commit your changes!"
