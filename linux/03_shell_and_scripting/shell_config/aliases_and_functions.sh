
## Aliases map long commands to shorter ones. Add them to ~/.bashrc or ~/.zshrc:

alias ll='ls -lah'     # List files with details
alias gs='git status'  # Shorten git status command

# Reload the configuration:
source ~/.bashrc

# To list all defined aliases:
alias


## Functions allow creating more complex reusable commands.

# Example function in ~/.bashrc:
function mybackup() {
    tar -czvf backup.tar.gz $1
    echo "Backup created for $1"
}

# Usage:
mybackup /path/to/directory

# To list all functions:
declare -F
