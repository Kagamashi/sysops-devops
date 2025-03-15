# Debian/Ubuntu (APT)
# package format .deb

# - always run sudo apt update before installing new packages to ensure latest versions
# - apt autoremove periodically to clean up unused dependencies
# - prefer apt over dpkg (dpkg doesn't resolve dependencies)
# - enable unattended-upgrades for security upgdates
      sudo apt install unattended-upgrades

apt                                      # High-level package manager
apt-get                                  # Low-level package handling utility
dpkg                                     # Debian package manager

sudo apt update	            # Refresh the package list.
sudo apt upgrade	          # Upgrade all installed packages.
sudo apt install package	  # Install a package.
sudo apt remove package	    # Remove a package (but keep config files).
sudo apt purge package	    # Remove a package and its config files.
sudo apt autoremove	        # Remove unused dependencies.
apt search package	        # Search for a package.
apt show package	          # Show package details.

apt install unattended-upgrades

apt-get update                    # Update the package list
apt-get upgrade                   # Upgrade all installed packages
apt-get install <package_name>    # Install a package
apt-get remove <package_name>     # Remove a package
apt-get autoremove                # Remove unnecessary packages
apt-get -f install                # Fix broken dependencies
