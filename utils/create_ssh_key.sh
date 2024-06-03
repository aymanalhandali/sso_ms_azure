#!/bin/bash

# Prompt the user for their GitHub email
read -p "Enter your GitHub email: " email

# Generate an SSH key
ssh-keygen -t ed25519 -C "$email"

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add your SSH private key to the ssh-agent
ssh-add ~/.ssh/id_ed25519

# Display the SSH public key
echo "Your SSH public key is:"
cat ~/.ssh/id_ed25519.pub

# Copy the SSH public key to the clipboard (requires xclip)
if command -v xclip &> /dev/null
then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
    echo "The SSH public key has been copied to your clipboard."
else
    echo "Install xclip to copy the SSH public key to your clipboard automatically."
    echo "Alternatively, manually copy the SSH public key displayed above."
fi

# Provide instructions to add the SSH key to GitHub
echo "Now, you need to add this SSH key to your GitHub account."
echo "1. Open GitHub and log in to your account."
echo "2. Go to Settings > SSH and GPG keys."
echo "3. Click on 'New SSH key', provide a title, and paste your SSH key."
echo "4. Click 'Add SSH key'."

echo "SSH key generation and setup complete."
