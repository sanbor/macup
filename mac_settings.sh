#! /usr/bin/env bash

# Copied from https://github.com/bkuhlmann/mac_os-config/tree/master/bin
# Applies system and application defaults.

printf "System - Disable window resume system-wide\n"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#printf "System - Disable auto-correct\n"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

printf "System - Avoid creating .DS_Store files on network volumes\n"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#printf "System - Disable software updates\n"
#sudo softwareupdate --schedule off

printf "Bluetooth - Increase sound quality for headphones/headsets\n"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

printf "Dock - Automatically hide and show\n"
defaults write com.apple.dock autohide -bool true

printf "Dock - Remove the auto-hiding delay\n"
defaults write com.apple.Dock autohide-delay -float 0

printf "Finder - Show the $HOME/Library folder\n"
chflags nohidden $HOME/Library

# printf "Finder - Show hidden files\n"
# defaults write com.apple.finder AppleShowAllFiles -bool true

printf "Finder - Show filename extensions\n"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

printf "Finder - Disable the warning when changing a file extension\n"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

printf "Finder - Show path bar\n"
defaults write com.apple.finder ShowPathbar -bool true

printf "Finder - Show status bar\n"
defaults write com.apple.finder ShowStatusBar -bool true

printf "Finder - Display full POSIX path as window title\n"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

printf "Finder - Use list view in all Finder windows\n"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

printf "Finder - Allow text selection in Quick Look\n"
defaults write com.apple.finder QLEnableTextSelection -bool true
