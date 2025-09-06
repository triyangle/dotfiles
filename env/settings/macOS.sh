#!/usr/bin/env bash

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock appswitcher-all-displays -bool true
killall Dock
