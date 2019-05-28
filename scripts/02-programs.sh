# Helper functions

# https://stackoverflow.com/questions/6682335/how-can-check-if-particular-application-software-is-installed-in-mac-os
whichapp() {
  local appNameOrBundleId=$1 isAppName=0 bundleId
  # Determine whether an app *name* or *bundle ID* was specified.
  [[ $appNameOrBundleId =~ \.[aA][pP][pP]$ || $appNameOrBundleId =~ ^[^.]+$ ]] && isAppName=1
  if (( isAppName )); then # an application NAME was specified
    # Translate to a bundle ID first.
    bundleId=$(osascript -e "id of application \"$appNameOrBundleId\"" 2>/dev/null) ||
      { echo "$FUNCNAME: ERROR: Application with specified name not found: $appNameOrBundleId" 1>&2; return 1; }
  else # a BUNDLE ID was specified
    bundleId=$appNameOrBundleId
  fi
    # Let AppleScript determine the full bundle path.
  fullPath=$(osascript -e "tell application \"Finder\" to POSIX path of (get application file id \"$bundleId\" as alias)" 2>/dev/null ||
    { echo "$FUNCNAME: ERROR: Application with specified bundle ID not found: $bundleId" 1>&2; return 1; })
  printf '%s\n' "$fullPath"
  # Warn about /Volumes/... paths, because applications launched from mounted
  # devices aren't persistently installed.
  if [[ $fullPath == /Volumes/* ]]; then
    echo "NOTE: Application is not persistently installed, due to being located on a mounted volume." >&2 
  fi
}

# Start of script

# Install Spotify if we don't have it
echo "Spotify:"
if ! whichapp 'spotify' &>/dev/null; then
echo "Installing Spotify..."
  brew cask install spotify
  mkdir ~/Library/Application\ Support/Spotify/

  # Spotify autologin
  cp ./private-data/Spotify/prefs ~/Library/Application\ Support/Spotify/prefs
fi
echo "Spotify is installed and configured"

# Install WhatsApp if we don't have it
echo "WhatsApp:"
if ! whichapp 'whatsapp' &>/dev/null; then
echo "Installing WhatsApp..."
  brew cask install whatsapp
fi
echo "WhatsApp is installed and configured"

# Install KeeWeb if we don't have it
echo "KeeWeb:"
if ! whichapp 'keeweb' &>/dev/null; then
echo "Installing KeyWeb..."
  brew cask install keeweb
fi
echo "KeyWeb is installed and configured"

