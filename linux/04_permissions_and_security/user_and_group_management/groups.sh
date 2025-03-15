
groupadd                                # add a new group
groupmod                                # modify group attributes
groupdel                                # delete a group
groups                                  # shows the groups the current user belongs to
gpasswd                                 # add OR remove user to/from a group
newgrp                                  # switch to a new group (in an active session)

groupadd newgroup                       # create a new group named "newgroup"
groupadd -g 1001 newgroup               # creates group with specific GID (Group ID)

groupmod -n newgroupname oldgroupname   # rename a group from "oldgroupname" to "newgroupname"
groupmod -g 2000 groupname

groupdel oldgroupname                   # delete the group "oldgroupname"

groups $user                            # shows groups the specified user is part of

gpasswd -d username group_name          # remove user from a specified group
gpasswd -a username group_name          # add user to a group using

newgrp group_name                       # temporarily switch to another group for the current session
