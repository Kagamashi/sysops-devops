
systemctl reboot  # reboot the system
shutdown          # halt, power-off/reboot the machine
systemctl rescue  # enter rescue mode

# shutdown - shut down/power off the server
# reboot - (same as 'shutdown -r') restart the server
# halt - immmediate shutdown

systemctl reboot                       # reboot the system immediately
systemctl reboot --force               # force a reboot without waiting for services to stop
systemctl poweroff                     # shutdown
systemctl poweroff --force

shutdown now                           # power off the machine immediately
shutdown -h now                        # halt the machine immediately
shutdown -r now                        # reboot the machine immediately
shutdown +5                            # schedule a shutdown in 5 minutes
shutdown -c                            # cancel a scheduled shutdown
shutdown 02:00                         # shutdown at 2am
shutdown -r +15                        # reboot in 15 minutes
# wall message - this message will be shown to users when machine is going to be rebooted
shutdown -r +1 'Scheduled restart to do an offline-backup of our database' 

systemctl rescue                       # enter rescue mode (single-user mode)

systemctl isolate graphical.target     # change to graphical mode without changing the default value
systemctl isolate emergency.target     # load up as few programs as possible

# Runlevels
# 0 - system halt - runlevel0.target, poweroff.target
# 1 - single user mode - runlevel1.target, rescue.target
# 2 - multi user - multi-user.target
# 3 - multi-user with network - runlevel3.target
# 4 - experimental - runlevel4.target
# 5 - multi-user, with network and graphical mode - graphical.target
# 6 - reboot - reboot.target
systemctl get-default                     # check current run-level
systemctl set-default multi-user.target

systemctl list-units --type target --all  # shows available targets
