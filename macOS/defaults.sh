#!/bin/sh

# prevent overrides
osascript -e 'tell application "System Preferences" to quit'

#############################
#### SAVING AND PRINTING ####
#############################

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

###############
#### INPUT ####
###############

# enable trackpad tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# disable “natural” (Lion-style) trackpad scrolling
defaults -currentHost write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# set trackpad tracking speed
defaults -currentHost write NSGlobalDomain com.apple.trackpad.scaling -float 0.6875
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.6875

##################
#### LANGUAGE ####
##################

# set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "es" "fa"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

################
#### FINDER ####
################

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# new windows open ~
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# show sidebar
defaults write com.apple.finder ShowSidebar -bool true

# sidebar width
defaults write com.apple.finder SidebarWidth -int 130

# don't show tags in sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# use list view in all windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# enable spring loading (drag to enter) for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# lessen the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

# don't create .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

##############
#### DOCK ####
##############

# enable highlight hover effect for the grid view of a stack
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# set size of dock icons to 55px
defaults write com.apple.dock tilesize -int 55

# disable magnification on hover
defaults write com.apple.dock magnification -bool false

# do not show indicator lights for open applications (only open ones shown)
defaults write com.apple.dock show-process-indicators -bool false

# position on the left of the screen
defaults write com.apple.dock orientation -string left

# automatically hide and show
defaults write com.apple.dock autohide -bool true

# remove the auto-hiding delay
defaults write com.apple.dock autohide-delay -float 0

# make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# don’t show recent applications
defaults write com.apple.dock show-recents -bool false

# clear apps from the dock, so only active ones show
defaults write com.apple.dock persistent-apps -array

###################
#### SPOTLIGHT ####
###################

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "SOURCE";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 1;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

##################
#### TERMINAL ####
##################

# https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# don't show line marks
defaults write com.apple.Terminal ShowLineMarks -bool false

##############
#### MISC ####
##############

# use CloudFlare DNS servers
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1

# plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -bool false

# don't open Photos automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# disable real time presence (document editing status) in drive fs
defaults write com.google.drivefs.settings DisableRealTimePresence -bool true
