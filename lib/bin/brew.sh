# Install GNU core utilities (those that come with OS X are outdated)
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
# Install Bash 4, zsh, emacs, mysql, git, php55, node, wget, curl, imagemagick, etc.
# NOTE: Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

# MYSQL: requires additional work to insure it starts at boot
# ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
# mysql_install_db --verbose --user=whoami --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
# mysql.server start
readonly brew=/usr/local/bin/brew
readonly fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
  font-open
  font-open-sans-condensed
  font-pt-sans
  font-pt-sans-narrow
  font-pt-mono
  font-pt-serif
  font-oswald
  font-droid-sans
  font-lato
  font-arvo
  font-playfair-display
  font-ubuntu
  font-montserrat
  font-raleway
  font-oxygen
  font-merriweather
  font-old-standard-tt
  font-abril-fatface
)
readonly bins=(
  coreutils
  bash
  findutils
  homebrew/dupes/grep
  php55
  z
  lua52
  bash-completion
  zsh
  mysql
  mplayer
  emacs
  git
  curl
  gpg
  reattach-to-user-namespace
  hub
  ffmpeg
  imagemagick
  imagesnap
  geeqie
  tree
  awscli
  s3cmd
  tig
  pngquant
  tmux
  parallel
  htop
  node
  'wget --enable-iri'
  ack
  lynx
  youtube-dl
  pigz
  rename
  mobile-shell
  rhino
  webkit2png
  zopfli
  httpie
  p7zip
  ngrep
)

readonly apps=(
  dropbox
  google-chrome
  google-chrome-canary
  google-drive
  google-hangouts
  google-music-manager
  google-web-designer
  chromecast
  iterm2
  textmate
  dash
  the-unarchiver
  abobe-creative-cloud
  colorpicker
  torbrowser
  virtualbox
  vlc
  xquartz
  rdio
  android-file-transfer
  crashlytics
  skype
  evernote
  divvy
  caffeine
  github
  handbrake
  mamp
  mono-mdk
  firefox
  perian
  bee
  silverlight
  transmit
  trailrunner
  vagrant
  flip4mac
  bitcoin-core
  gpgtools
  charles  
)

function command_exists () {
    type "$1" &> /dev/null ;
}

function main () {
  $brew tap homebrew/versions
  $brew tap homebrew/dupes
  $brew tap caskroom/fonts
  $brew tap caskroom/versions
  $brew tap josegonzalez/homebrew-php
  # Upgrade any already-installed formulae
  $brew update
  $brew upgrade
  
  # Install binaries
  echo -e "\nInstalling bins..."
  $brew install ${bins[@]}
  # TODO: This doesn't work as desired because the brew name and the command name differ
  # for binary in "${bins[@]}"
  # do
  #   if ! command_exists $binary; then
  #     echo -e "$binary not found, installing..."
  #     #$brew install ${bins[@]}
  #   else
  #     echo -e "$binary already installed"
  #   fi
  # done
  
  # Install apps
  echo -e "\nInstalling apps..."
  $brew cask install ${apps[@]}

  # Install fonts
  echo -e "\nInstalling fonts..."
  $brew cask install ${fonts[@]}

  # Cleanup
  $brew cleanup
  $brew cask cleanup

  # Doctor
  $brew cask doctor
  $brew doctor
}

main
unset command_exists
unset main
exit 0
