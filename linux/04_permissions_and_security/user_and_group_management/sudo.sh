
su -                    # become root

sudo command            # run a command with superuser (root) privileges
sudo su                 # switch to the root user (superuser)
sudo -l                 # list the sudo privileges for the current user
sudo -l -U username     # list the sudo privileges for a specific user
sudo -u username        # execute command as different user

# wheel group is authorized to act as root; 
# every member can execute all commands as root with syntax 'sudo command'
sudo usermod -aG sudo username             # add a user to sudoers group, granting them sudo privileges
usermod -aG wheel username

sudo visudo                                # open sudo file for editing
# visudo configuration:
demo ALL=(ALL:ALL) ALL​  # first field indicates the username that the rule will apply to.
demo ALL=(ALL:ALL) ALL​  # first "ALL" indicates that this rule applies to all hosts.
demo ALL=(ALL:ALL) ALL​  # "ALL" indicates that user demo can run commands as all users.
demo ALL=(ALL:ALL) ALL​  # "ALL" indicates that user demo can run commands as all groups.
demo ALL=(ALL:ALL) ALL​  # last "ALL" indicates these rules apply to all commands.
