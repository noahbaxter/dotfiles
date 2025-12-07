#!/bin/bash
# Install REAPER config from dotfiles to REAPER config folder
# Run this after fresh REAPER install
#
# This script will:
# 1. Check/install required extensions (SWS, ReaPack, js_ReaScriptAPI)
# 2. Copy all config files
# 3. Copy scripts, themes, icons, etc.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REAPER_DIR="$HOME/Library/Application Support/REAPER"
PLUGINS_DIR="$REAPER_DIR/UserPlugins"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  REAPER Config Installer"
echo "=========================================="
echo ""

# Check REAPER is installed
if [[ ! -d "$REAPER_DIR" ]]; then
    echo -e "${RED}REAPER config folder not found at $REAPER_DIR${NC}"
    echo "Install REAPER and run it once first: https://www.reaper.fm/download.php"
    exit 1
fi

mkdir -p "$PLUGINS_DIR"

# ==========================================
# Extension Installation
# ==========================================

echo "Checking extensions..."
echo ""

# SWS Extension
# NOTE: URL version may be outdated - check https://www.sws-extension.org/ for latest
SWS_URL="https://www.sws-extension.org/download/pre-release/sws-v2.14.0.3-Darwin-arm64.dmg"
if [[ ! -f "$PLUGINS_DIR/reaper_sws-arm64.dylib" ]] && [[ ! -f "$PLUGINS_DIR/reaper_sws_extension.dylib" ]]; then
    echo -e "${YELLOW}SWS Extension not found.${NC}"
    echo "Download from: https://www.sws-extension.org/"
    echo "  Direct link: $SWS_URL"
    echo ""
    read -p "Download and install SWS now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Downloading SWS..."
        curl -L "$SWS_URL" -o /tmp/sws.dmg
        echo "Mounting DMG..."
        hdiutil attach /tmp/sws.dmg -quiet
        echo "Installing SWS..."
        cp -R /Volumes/sws*/UserPlugins/* "$PLUGINS_DIR/"
        hdiutil detach /Volumes/sws* -quiet
        rm /tmp/sws.dmg
        echo -e "${GREEN}  ✓ SWS Extension installed${NC}"
    fi
else
    echo -e "${GREEN}  ✓ SWS Extension already installed${NC}"
fi

# ReaPack
# NOTE: URL version may be outdated - check https://reapack.com/ for latest
REAPACK_URL="https://github.com/cfillion/reapack/releases/download/v1.2.4.5/reaper_reapack-arm64.dylib"
if [[ ! -f "$PLUGINS_DIR/reaper_reapack-arm64.dylib" ]] && [[ ! -f "$PLUGINS_DIR/reaper_reapack.dylib" ]]; then
    echo -e "${YELLOW}ReaPack not found.${NC}"
    echo "Download from: https://reapack.com/"
    echo ""
    read -p "Download and install ReaPack now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Downloading ReaPack..."
        curl -L "$REAPACK_URL" -o "$PLUGINS_DIR/reaper_reapack-arm64.dylib"
        echo -e "${GREEN}  ✓ ReaPack installed${NC}"
    fi
else
    echo -e "${GREEN}  ✓ ReaPack already installed${NC}"
fi

# js_ReaScriptAPI (installed via ReaPack, but check anyway)
if [[ ! -f "$PLUGINS_DIR/reaper_js_ReaScriptAPI64ARM.dylib" ]] && [[ ! -f "$PLUGINS_DIR/reaper_js_ReaScriptAPI.dylib" ]]; then
    echo -e "${YELLOW}  ! js_ReaScriptAPI not found - install via ReaPack after setup${NC}"
    echo "    (Extensions > ReaPack > Browse packages > search 'js_ReaScriptAPI')"
else
    echo -e "${GREEN}  ✓ js_ReaScriptAPI already installed${NC}"
fi

echo ""
echo "Installing config files..."

# ==========================================
# Config Files
# ==========================================

for file in reaper.ini reaper-kb.ini reaper-mouse.ini reaper-menu.ini reaper-wndpos.ini reaper-fxtags.ini reapack.ini "S&M.ini" "sws-autocoloricon.ini" "BR.ini"; do
    if [[ -f "$SCRIPT_DIR/$file" ]]; then
        cp "$SCRIPT_DIR/$file" "$REAPER_DIR/$file"
        echo -e "${GREEN}  ✓ $file${NC}"
    fi
done

# ==========================================
# Folders
# ==========================================

# Scripts (clear and sync)
if [[ -d "$SCRIPT_DIR/Scripts" ]]; then
    mkdir -p "$REAPER_DIR/Scripts/User"
    # Clear old user scripts and copy fresh
    rm -rf "$REAPER_DIR/Scripts/User/"*
    cp -R "$SCRIPT_DIR/Scripts/"* "$REAPER_DIR/Scripts/User/"
    echo -e "${GREEN}  ✓ Scripts/ -> Scripts/User/ (synced)${NC}"
fi

# Color themes
if [[ -d "$SCRIPT_DIR/ColorThemes" ]]; then
    mkdir -p "$REAPER_DIR/ColorThemes"
    cp "$SCRIPT_DIR/ColorThemes/"* "$REAPER_DIR/ColorThemes/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ ColorThemes/${NC}"
fi

# MIDI note names
if [[ -d "$SCRIPT_DIR/MIDINoteNames" ]]; then
    mkdir -p "$REAPER_DIR/MIDINoteNames"
    cp "$SCRIPT_DIR/MIDINoteNames/"* "$REAPER_DIR/MIDINoteNames/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ MIDINoteNames/${NC}"
fi

# FX Chains
if [[ -d "$SCRIPT_DIR/FXChains" ]]; then
    mkdir -p "$REAPER_DIR/FXChains"
    cp -R "$SCRIPT_DIR/FXChains/"* "$REAPER_DIR/FXChains/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ FXChains/${NC}"
fi

# Track templates
if [[ -d "$SCRIPT_DIR/TrackTemplates" ]]; then
    mkdir -p "$REAPER_DIR/TrackTemplates"
    cp -R "$SCRIPT_DIR/TrackTemplates/"* "$REAPER_DIR/TrackTemplates/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ TrackTemplates/${NC}"
fi

# Project templates
if [[ -d "$SCRIPT_DIR/ProjectTemplates" ]]; then
    mkdir -p "$REAPER_DIR/ProjectTemplates"
    cp -R "$SCRIPT_DIR/ProjectTemplates/"* "$REAPER_DIR/ProjectTemplates/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ ProjectTemplates/${NC}"
fi

# Custom toolbar icons
if [[ -d "$SCRIPT_DIR/Data/toolbar_icons" ]]; then
    mkdir -p "$REAPER_DIR/Data/toolbar_icons"
    cp "$SCRIPT_DIR/Data/toolbar_icons/"* "$REAPER_DIR/Data/toolbar_icons/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ Data/toolbar_icons/${NC}"
fi

# ==========================================
# Done
# ==========================================

echo ""
echo "=========================================="
echo -e "${GREEN}  Installation complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "  1. Restart REAPER"
echo ""
echo "  2. Install required ReaPack packages:"
echo "     Extensions > ReaPack > Browse packages"
echo ""
echo "     Required packages:"
if [[ -f "$SCRIPT_DIR/reapack-packages.txt" ]]; then
    grep -v "^#" "$SCRIPT_DIR/reapack-packages.txt" | grep -v "^$" | while read -r line; do
        pkg=$(echo "$line" | cut -d'#' -f1 | xargs)
        [[ -n "$pkg" ]] && echo "       - $pkg"
    done
fi
echo ""
echo "  3. Re-register custom scripts (FIRST TIME ONLY):"
echo "     Actions > Show action list > New action > Load ReaScript"
echo "     Load each script from: Scripts/User/"
echo "     Then re-bind keyboard shortcuts as needed."
echo ""
echo "     After re-binding, run grab.sh to save the new bindings!"
echo ""
echo "  4. Run: Extensions > ReaPack > Synchronize packages"
echo ""
