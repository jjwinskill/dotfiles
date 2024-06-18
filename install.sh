#!/bin/bash

echo "Oh hello Josh"

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "We spared no expense"

# Ensure Zsh is the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s $(which zsh)
fi

echo "We have a t-rex"

# Install powerlevel10k theme if not already installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

echo "Dino DNA"

# Ensure .zshrc exists and source it
if [ ! -f "$HOME/.zshrc" ]; then
  echo "Creating .zshrc file..."
  touch $HOME/.zshrc
fi

echo "Sourcing .zshrc to apply changes..."
source "$HOME/.zshrc"

echo "Hold on to your butts..."
