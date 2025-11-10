#!/bin/bash

# macOS Defaults Setup Script
# You'll need to logout/login or restart for many changes to take effect

set -e

echo "Setting macOS defaults for power users..."

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo "→ Setting general UI preferences..."

# Show scroll bars "When scrolling" (other options: "Automatic", "Always")
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard                                                  #
###############################################################################

echo "→ Setting input device preferences..."

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Set a faster trackpad tracking speed
defaults write NSGlobalDomain com.apple.mouse.scaling -float "0.875"

# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Disable shake mouse pointer to locate
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

# Set pointer size (range: 1.0 to 4.0, default is 1.0)
defaults write NSGlobalDomain com.apple.mouse.size -float 1.5

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

echo "→ Setting screen preferences..."

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Displays have separate Spaces
defaults write com.apple.spaces "spans-displays" -bool "false"

###############################################################################
# Finder                                                                      #
###############################################################################

echo "→ Setting Finder preferences..."

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use column view in all Finder windows by default
# Four-letter codes for view modes: `icnv`, `clmv`, `glyv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Dock, Dashboard, and hot corners                                           #
###############################################################################

echo "→ Setting Dock preferences..."

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 48

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Menu Bar                                                                    #
###############################################################################

echo "→ Setting menu bar preferences..."

# Set menu bar size to large
defaults write NSGlobalDomain NSStatusItemSelectionPadding -int 12
defaults write NSGlobalDomain NSStatusItemSpacing -int 10

# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Set 24-hour clock format
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Show date in menu bar with 24-hour time
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  HH:mm"

# Flash time separators
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# Analog or digital clock (true = analog)
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Always show Sound in menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"

# Remove Siri from menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false
defaults delete com.apple.Siri StatusMenuVisible 2>/dev/null || true

###############################################################################
# Siri, Apple Intelligence, and Privacy                                      #
###############################################################################

echo "→ Disabling Siri and Apple Intelligence..."

# Disable Siri completely
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Disable Siri voice feedback
defaults write com.apple.assistant.backedup "Use device speaker for TTS" -int 3

# Disable Siri system-wide
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri UserHasDeclinedEnable -bool true
defaults write com.apple.assistant.support "Siri Data Sharing Opt-In Status" -int 2

# Turn off "Ask Siri"
defaults write com.apple.SetupAssistant DidSeeCloudSetup -bool true
defaults write com.apple.SetupAssistant DidSeeSiriSetup -bool true

# Disable Siri suggestions in Spotlight
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# Help Apple Improve Siri & Dictation OFF
defaults write com.apple.assistant.support "Siri Data Sharing Opt-In Status" -int 2

# Turn off Apple Intelligence (if available on your Mac)
defaults write com.apple.intelligenceplatform.support IntelligencePlatformEnabled -bool false 2>/dev/null || true

# Help Apple Improve Search OFF
defaults write com.apple.assistant.support "Search Queries Data Sharing Status" -int 2

# Show Related Content OFF (in Siri Suggestions)
defaults write com.apple.suggestions.plist SuggestionsAppLibraryEnabled -bool false 2>/dev/null || true
defaults write com.apple.Safari ShowSiriSuggestionsPreference -bool false 2>/dev/null || true

###############################################################################
# Screen Saver                                                               #
###############################################################################

echo "→ Setting screen saver preferences..."

# Set screen saver to Drift with Color Spectrum
# First, set the module to Drift
defaults -currentHost write com.apple.screensaver moduleDict -dict \
    moduleName -string "Drift" \
    path -string "/System/Library/Screen Savers/Drift.saver" \
    type -int 0

# Set Drift to use Color Spectrum mode (mode 3)
# Drift modes: 0 = Classic, 1 = Metallic, 2 = Noir, 3 = Color Spectrum
defaults -currentHost write com.apple.screensaver "com.apple.screensaver.drift" -dict \
    mode -int 3

# Set screen saver idle time to 5 minutes (300 seconds) - adjust as needed
defaults -currentHost write com.apple.screensaver idleTime -int 300

###############################################################################
# Activity Monitor                                                           #
###############################################################################

echo "→ Setting Activity Monitor preferences..."

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Photos                                                                      #
###############################################################################

echo "→ Setting Photos preferences..."

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Default Applications                                                       #
###############################################################################

echo "→ Setting default applications..."

# Set Firefox as default browser (requires Firefox to be installed)
if [ -d "/Applications/Firefox.app" ]; then
    # Set Firefox as default for HTTP/HTTPS
    defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
        '{LSHandlerContentType=public.html;LSHandlerRoleAll=org.mozilla.firefox;}' \
        '{LSHandlerContentType=public.xhtml;LSHandlerRoleAll=org.mozilla.firefox;}' \
        '{LSHandlerURLScheme=http;LSHandlerRoleAll=org.mozilla.firefox;}' \
        '{LSHandlerURLScheme=https;LSHandlerRoleAll=org.mozilla.firefox;}'

    echo "  ✓ Set Firefox as default browser (may need to confirm in Firefox)"
else
    echo "  ⚠ Firefox not found, skipping browser default"
fi

###############################################################################
# Done!                                                                       #
###############################################################################

echo ""
echo "✓ Done! Note that some changes require a logout/restart to take effect."
echo ""
echo "To apply changes immediately, run:"
echo "  killall Dock && killall Finder && killall SystemUIServer"
echo ""

# Optional: Restart affected applications
read -p "Kill affected applications (Dock, Finder, SystemUIServer, etc.) now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    killall Dock
    killall Finder
    killall SystemUIServer
    echo "Applications restarted. You may need to logout/login for all changes to take effect."
fi