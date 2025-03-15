# environment variables defines system-wide and user-specifc settings

env          # List all environment variables
printenv     # Print specific environment variables

# temporary (for current session only)
export VAR_NAME="value"
echo $VAR_NAME 

# permanent (add to ~/.bashrc, ~/.zshrc, or ~/.profile)
echo 'export VAR_NAME="value"' >> ~/.bashrc
source ~/.bashrc