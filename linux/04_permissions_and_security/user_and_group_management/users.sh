
useradd                                 # add new users
usermod                                 # modify user accounts
userdel                                 # delete a user account
passwd                                  # update user passwords
chage                                   # change user password expiry information
id                                      # display user identity
who                                     # show who is logged on
whoami                                  # print the current user
last                                    # show a listing of last logged in users
groups                                  # show group memberships
finger                                  # user information lookup

useradd $user                          # add new user named "$user"
useradd -m $user                       # add new user and create a home directory
useradd -s /bin/bash $user             # specific shell
useradd -u 1100 $user                  # specific USER ID
useradd --system sysacc                # create system account intended for programs (no home directory)
useradd -d /home/otherdirectory/ $user # adds user with different home directory
useradd -D                             # print default configuration (/etc/default/useradd)

usermod -aG groupname $user            # add "$user" to an existing group
usermod -d /home/user $user            # change the home directory of "$user"
usermod -l $user oldusername           # change the username from "oldusername" to "$username"
usermod -s /bin/othershell $user       # change shell for '$user'
usermod -L/--lock $user                # lock user - user will no longer be able to log in with password (but can with ssh)
usermod -U/--unlock
usermod -e 2021-12-10 $user            # set expire date for $user - date format YEAR-MONTH-DAY
usermod -e "" $user                    # remove expire date
sudo usermod -aG sudo username         # add user to sudoers group, granting them sudo privileges

userdel $user                       # delete the user "$user"
userdel -r $user                    # delete the user and their home directory

passwd $user                        # change the password for a specific user
passwd                              # change the password for the current user
passwd -l user                      # lock password of user

chage -l $user                      # list password expiration information for a user
chage -E 2025-12-31 $user           # set account expiration date for a user
chage -M 30 $user                   # set the maximum number of days before a password must be changed
chage -M -1 $user                   # password never expires
chage -m 5 $user                    # set the minimum number of days between password changes
chage -d 0 $user                    # set expire date of password for right now
chage -d -1 $user                   # unexpire the password (revert previous chage)

id                                  # show the user ID (UID) and group ID (GID)
id $user                            # show the UID and GID for a specific user

who                                 # list users currently logged into the system

whoami                              # display the username of the current user

last                                # show the last logged in users
last -n 10                          # show the last 10 logged in users

groups                              # show the groups for the current user
groups $user                        # show the groups for a specific user

finger $user                        # display information about a specific user
finger                              # show information about all users
