
# background processes
command &                           # run a command in the background.
jobs                                # list processes running in the background
fg [pid]                            # bring a background job to the foreground
bg [pid]                            # move a stopped job to the background
kill [pid]                          # kill a background job using its job number

Ctrl + Z    # pause foreground job
bg    # resume paused job in the background
fg    # bring background job to the foreground
