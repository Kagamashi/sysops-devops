
# Settings can be configured:
# - system-wide (--system) - applies to all users on the system and is stored in Git installation folder
# - global (--global) - applies to all repositories for current user and is stored in ~/.gitconfig
# - local - applies only to specific repository and is stored in .git/config file within the repository

# Set username and email - Git uses this information to identify YOU in commit logs
git config --global user.name "Miki"
git config --global user.email "miki@gmail.com"

# To set only for specific repository
git config user.name "Miki"
git config user.email "miki@gmail.com"

# View all Git configuration
git config --list

# Check specific configuration value
git config user.email

# Specify text editor to use for Git commit messages
git config --global core.editor "vim"

# Auto-line ending conversion - handles line ending differences between Windows (CRLF) and Unix (LF) systems 
git config --global core.autocrlf true  # Windows
git config --global core.autocrlf input # Unix/MacOS

# Create shortcuts for common Git commands using aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch

git st # equivalent to 'git status'

# To enable colored output in Git commands
git config --global color.ui auto
