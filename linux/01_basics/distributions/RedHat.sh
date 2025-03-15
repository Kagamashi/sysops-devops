# Red Hat/CentOS/Fedora (DNF/YUM)
# package format .rpm

# - use dnf check-update to preview available updates before applying them
# - enable EPEL repository for extra packages
      sudo dnf install epel-release
# - use dnf history to review and undo package transactions
      sudo dnf history list
      sudo dnf history undo <ID>
# - remove unneeded packages with dnf autoremove

yum                                      # Package manager for RPM-based distributions (now mostly dnf)
dnf                                      # Newer package manager for RPM-based distributions
rpm                                      # RPM package manager

# for RedHat/CentOS 7 and older, use YUM. For newer versions, use DNF (YUM is still available as a wrapper)

sudo dnf update	          # Update all installed packages.
sudo dnf install package	# Install a package.
sudo dnf remove package	  # Remove a package.
sudo dnf search package	  # Search for a package.
sudo dnf list installed	  # List installed packages.
sudo dnf autoremove       #	Remove unnecessary packages.
sudo dnf history list

rpm -ivh <package_file.rpm>              # Install an RPM package
rpm -e <package_name>                    # Remove an installed package
rpm -q <package_name>                    # Query if a package is installed
rpm -qa                                  # List all installed packages
rpm -qpi <package_file.rpm>              # Display package information without installing
