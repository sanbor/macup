#!/bin/sh

# Basic macOS bootstrap

# WARNING: This script has never been run for real. I just use it to avoid work in the future.
# When I start running this script for real I'll remove this legend.

# Exit when some command fails (more info http://www.davidpashley.com/articles/writing-robust-shell-scripts/#id2382181)
set -e

echo "Please enter your full name to be used in git config:"
read name

echo "Please enter email to generate ssh key and to be set in git config:"
read email

# Set hostname to host to be more generic
sudo scutil –-set HostName host

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Disable Google analytics
brew analytics off

# Install Google Chrome, Firefox, iTerm2, java, etc.
brew cask install google-chrome firefox iterm2 vlc atom virtualbox vagrant \
  docker vagrant-manager sublime-text santa djview mullvad xquartz gimp \
  inkscape anki java eclipse-jee intellij-idea libreoffice boxer \
  mysqlworkbench torbrowser insomnia veracrypt osxfuse wireshark \
  caffeine

# maybe useful cyberduck sweet-home3d

# Install git, syncthing, pass, etc.
# gotchas: gpg-agent is required to avoid issues with pass
brew install git syncthing pass gpg gpg-agent mc ranger mplayer ffmpeg youtube-dl zsh zsh-completions \
  autojump tmux emacs pandoc node mtr p7zip aria2 python ipython plantuml ext4fuse tunnelblick cryptomator
  
# MAC spoofing app
brew install spoof-mac

# Get the list of devices
# spoof-mac list
# Try to see if it works
# sudo spoof-mac randomize en0 en1

# randomize WiFi (en0) MAC address at start up time
sudo brew services start spoof-mac

# To have launchd start syncthing now and restart at login
brew services start syncthing

# You may want to edit the plist file from
#    <string>en0</string>
# to e.g.:
#    <string>en0 en1</string>
# sudo vim /Library/LaunchDaemons/homebrew.mxcl.spoof-mac.plist

# optionals
# brew install yarn nginx
# brew cask install visual-studio-code google-drive

# Install GNU utilities (they are more updated than the ones shipped with macOS)
# Guide to avoid appending the g in some commands https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
brew install coreutils binutils diffutils ed findutils gawk gnu-indent gnu-sed \
  gnu-tar gnu-which gnutls grep gzip screen watch wdiff wget bash gdb gpatch \
  m4 make nano file-formula git less openssh rsync svn unzip vim

# Atom packages
apm install plantuml-viewer hydrogen

# Npm packages
npm install --global ijavascript gulp-cli create-react-app lite-server

# Python packages
pip3 install --upgrade pip
pip3 install jupyter jupyter_contrib_nbextensions pandas

# Setup vim
cp ~/.vimrc ~/.vimrc.bak || true # Try to backup just in case
cp ./dot.vimrc ~/.vimrc

# Setup zsh (more info https://wiki.archlinux.org/index.php/zsh)
cp ~/.zshrc ~/.zshrc.bak || true # Try to backup just in case
cp ./dot.zshrc ~/.zshrc
echo "[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh">>~/.zshrc
echo "export PATH=\"/usr/local/bin:/usr/local/sbin:~/bin:$PATH\"">>~/.zshrc
sudo echo "$(which zsh)" >> /etc/shells
chsh -s $(which zsh)

# Create keys for the machine
mkdir ~/.ssh || true
ssh-keygen -t rsa -b 4096 -C "$email"
eval "$(ssh-agent -s)"
mv ~/.ssh/.ssh_config ~/.ssh/.ssh_config.back || true # Try to backup just in case
cp ~/dot.ssh_config ~/.ssh/config
ssh-add -K ~/.ssh/id_rsa

# Setup git
cp ~/.gitconfig ~/.gitconfig.bak || true # Try to backup just in case
cp ./dot.gitconfig ~/.gitconfig
cp ~/.gitignore ~/.gitignore.bak || true # Try to backup just in case
cp ./dot.gitignore ~/.gitignore
git config --global user.name "$name"
git config --global user.email "$email"
git config --global core.editor vim
git config --list

# Disable Chrome mouse gestures
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# Setup android development, from https://gist.github.com/patrickhammond/4ddbe49a67e5eb1b9c03
brew install ant maven gradle
brew cask install brew cask install android-studio
