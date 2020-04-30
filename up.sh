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
brew cask install google-chrome firefox iterm2 vlc vscodium virtualbox vagrant \
  virtualbox-extension-pack docker santa djview mullvadvpn \
  gimp krita xquartz inkscape anki intellij-idea-ce libreoffice boxer \
  mysqlworkbench tor-browser osxfuse wireshark keybase \
  knockknock blockblock little-snitch micro-snitch cryptomator emacs \
  miniconda caskroom/versions/java8 kap spotify android-file-transfer \
  skype android-platform-tools alfred

# Install Guest Additions
vagrant plugin install vagrant-vbguest

# Install git, syncthing, pass, etc.
# gotchas: gpg-agent is required to avoid issues with pass
brew install git gnupg mc ranger mplayer mpv ffmpeg \
    youtube-dl zsh zsh-completions autojump tmux pandoc node mtr p7zip \
    aria2 python ipython jupyter plantuml ext4fuse htop maven gradle \
    wireguard-tools bash-completion fish httpie

# maybe useful cyberduck sweet-home3d veracrypt cryptomator mysqlworkbench

# MAC spoofing app
brew install spoof-mac

# Get the list of devices
# spoof-mac list
# Try to see if it works
# sudo spoof-mac randomize en0

# randomize WiFi (en0) MAC address at start up time
# sudo brew services start spoof-mac

# You may want to edit the plist file from
#    <string>en0</string>
# to e.g.:
#    <string>en0 en1</string>
# sudo vim /Library/LaunchDaemons/homebrew.mxcl.spoof-mac.plist

# optionals
# brew install yarn nginx

# Install GNU utilities (they are more updated than the ones shipped with macOS)
# Guide to avoid appending the g in some commands https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
brew install coreutils binutils diffutils ed findutils gawk gnu-indent gnu-sed \
  gnu-tar gnu-which gnutls grep gzip screen watch wdiff wget bash gdb gpatch \
  m4 make nano file-formula git less openssh ssh-copy-id rsync svn unzip vim imagemagick --with-webp


# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng bfg binutils binwalk cifer dex2jar dns2tcp fcrackzip foremost hashpump \
#  hydra john knock netpbm nmap pngcheck socat sqlmap tcpflow tcpreplay \
#  tcptrace ucspi-tcp xpdf xz
# Npm packages
# npm install --global ijavascript gulp-cli create-react-app lite-server

# Npm packages
# npm install --global ijavascript gulp-cli create-react-app lite-server

# Setup vim
cp ~/.vimrc ~/.vimrc.bak || true # Try to backup just in case
cp ./dot.vimrc ~/.vimrc

# Setup zsh (more info https://wiki.archlinux.org/index.php/zsh)
# cp ~/.zshrc ~/.zshrc.bak || true # Try to backup just in case
# cp ./dot.zshrc ~/.zshrc
# echo "[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh">>~/.zshrc
# echo "export PATH=\"/usr/local/bin:/usr/local/sbin:~/bin:$PATH\"">>~/.zshrc

# Fish rulez!
sudo sh -c "echo $(which fish) >> /etc/shells"
chsh -s "$(which fish)"

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

# Add `auth sufficient pam_tid.so` to the top of /etc/pam.d/sudo file
sudo bash -eu <<'EOF'
  file=/etc/pam.d/sudo
  # A backup file will be created with the pattern /etc/pam.d/.sudo.1
  # (where 1 is the number of backups, so that rerunning this doesn't make you lose your original)
  bak=$(dirname $file)/.$(basename $file).$(echo $(ls $(dirname $file)/{,.}$(basename $file)* | wc -l))
  cp $file $bak
  awk -v is_done='pam_tid' -v rule='auth       sufficient     pam_tid.so' '
  {
    # $1 is the first field
    # !~ means "does not match pattern"
    if($1 !~ /^#.*/){
      line_number_not_counting_comments++
    }
    # $0 is the whole line
    if(line_number_not_counting_comments==1 && $0 !~ is_done){
      print rule
    }
    print
  }' > $file < $bak
EOF

# Set sudo grace period to 0
echo 'Defaults timestamp_timeout=0' | sudo EDITOR='tee -a' visudo

# To find available bundle ids: lsappinfo | grep 'bundleID="' | cut -d'"' -f2 | sort
# To check current app associated to an extension: duti -x js
# visual studio code bundle id is com.microsoft.VSCode
# but I'm using VSCodium bundle id instead
duti -s com.visualstudio.code.oss .xml all
duti -s com.visualstudio.code.oss .json all
duti -s com.visualstudio.code.oss .c all
duti -s com.visualstudio.code.oss .cpp all
duti -s com.visualstudio.code.oss .cs all
duti -s com.visualstudio.code.oss .css all
duti -s com.visualstudio.code.oss .go all
duti -s com.visualstudio.code.oss .java all
duti -s com.visualstudio.code.oss .js all
duti -s com.visualstudio.code.oss .sass all
duti -s com.visualstudio.code.oss .scss all
duti -s com.visualstudio.code.oss .less all
duti -s com.visualstudio.code.oss .vue all
duti -s com.visualstudio.code.oss .cfg all
duti -s com.visualstudio.code.oss .json all
duti -s com.visualstudio.code.oss .jsx all
duti -s com.visualstudio.code.oss .lua all
duti -s com.visualstudio.code.oss .md all
duti -s com.visualstudio.code.oss .php all
duti -s com.visualstudio.code.oss .pl all
duti -s com.visualstudio.code.oss .py all
duti -s com.visualstudio.code.oss .rb all
duti -s com.visualstudio.code.oss .rs all
duti -s com.visualstudio.code.oss .sh all
duti -s com.visualstudio.code.oss .swift all
duti -s com.visualstudio.code.oss .txt all
duti -s com.visualstudio.code.oss .conf all
duti -s com.visualstudio.code.oss public.unix-executable all
duti -s com.visualstudio.code.oss public.plain-text all