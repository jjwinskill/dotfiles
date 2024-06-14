#!/bin/bash

# Install zsh if it is not already installed
if ! command -v zsh &> /dev/null
then
    echo "zsh not found, installing..."
    sudo apt-get update
    sudo apt-get install -y zsh
fi

# Change the default shell to zsh
chsh -s $(which zsh)

# Symlink .zshrc from the dotfiles repository to the home directory
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# Source the .zshrc file to apply the configuration
source ~/.zshrc

# Install VSCode extensions from extensions.txt
if command -v code &> /dev/null
then
    echo "Installing VSCode extensions..."
    while IFS= read -r extension; do
        code --install-extension "$extension"
    done < ~/dotfiles/vscode/extensions.txt
else
    echo "VSCode is not installed. Skipping extension installation."
fi

# Copy VSCode settings.json to the appropriate location
mkdir -p ~/.config/Code/User/
cp ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

echo "Setup complete!"