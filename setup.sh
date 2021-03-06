#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Install PHP, FPM, NGINX
sudo apt-get install -y php5-common php5-cgi php5-fpm nginx
# curel  - curl
# pspell - spelling
sudo apt-get install -y php-pear php5-curl php5-pspell
# Install xcache (instead of apc)
# http://www.imadalin.ro/weblog/2013/06/apc-vs-xcache/
sudo apt-get install -y php5-xcache 
# TODO: Install xcache admin
# http://www.tecmint.com/install-xcache-to-accelerate-and-optimize-php-performance/
sudo apt-get update

# Pear installations
sudo pear install -a Mail_Mime
sudo pear install Mail_mimeDecode

# Install Drush 
# https://drupal.org/node/1248790
sudo apt-get install -y drush
echo -e "2\ny\n" | sudo drush dl drush --destination='usr/share'
drush --version

# NGINX Drupal config 
# https://github.com/perusio/drupal-with-nginx
git clone https://github.com/Swifto/drupal-with-nginx.git
cd drupal-with-nginx
git checkout D7
cd $HOME

# Do we need this for dompdf ???
#https://github.com/PhenX/php-font-lib
#unzip
#mv to lib/php-font-lib
# apc?

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/Swifto/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

