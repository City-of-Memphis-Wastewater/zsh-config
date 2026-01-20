pkg install zsh

# clone this repo and cop  the .zshrc file to your local ~/.zshrc
git clone https://github.com/City-of-Memphis-Wastewater/zsh-config
cp ./zsh-config/.zshrc ~/.zshrc

# Add oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Do not use this on termux: make zsh default (instead of bash)
## chsh -s $(which zsh)

# install zsh-athocompletions as a OMZ custom plugin
mkdir -p ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

