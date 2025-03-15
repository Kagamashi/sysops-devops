
# top command provides a real-time view of system processes

top   # launch process viewer
top -u username   # show processes for specific user

k # while inside top it kills process by providing it's PID
q # quits from top


# htop is an interactive and user-friendly alternative to top
sudo apt install htop  # Debian/Ubuntu
sudo dnf install htop  # RedHat/Fedora

htop    # launch htop
Arrow keys    # navigate process list
F9      # kill selected process
F10     # quit htop
