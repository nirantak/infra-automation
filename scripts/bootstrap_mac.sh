#!/bin/bash
# Set up a new MacOS machine
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.12.4

echo -e "\n \x1B[32m Setting up Dev Env \x1B[0m"
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo chown -R $USER:$(id -gn $USER) ~/.config

echo -e "\n \x1B[32m Installing Packages \x1B[0m"
brew install curl wget git tree htop vim tmux zsh zsh-completions bat
brew install ctags gnu-time gnu-sed grep gpgme pinentry-mac watch
brew install python3 node go gcc svn pandoc lynx imagemagick k9s
brew install autossh vnstat openvpn coreutils hping wrk mtr inetutils nmap
brew install cloudflared nirantak/tap/sshpass gh sox pipx hyperfine
brew install diff-so-fancy grc lnav cloc jq fzf ripgrep shellcheck

echo -e "\n \x1B[32m Installing Apps \x1B[0m"
brew install --cask rectangle wezterm istat-menus raycast visual-studio-code
brew install --cask google-chrome brave-browser slack zoom
brew install --cask spotify vlc obsidian 1password karabiner-elements
brew install --cask android-file-transfer docker balenaetcher

echo -e "\n \x1B[32m Setting up Terminal \x1B[0m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$(brew --prefix)/opt/fzf/install --all

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

curl -L "https://raw.github.com/pyenv/pyenv-installer/master/bin/pyenv-installer" | bash

brew tap homebrew/services
brew tap tinygo-org/tools
brew install --cask font-fira-code font-source-code-pro font-hack-nerd-font
brew install tinygo avrdude
npm install -g browser-sync speed-test eslint prettier

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip install -U pip wheel setuptools
pip install -U black flake8 ipython
for package in httpie youtube-dl powerline-status pre-commit;
  do pipx install $package;
done

node --version
go version
python --version

sudo brew services restart vnstat
