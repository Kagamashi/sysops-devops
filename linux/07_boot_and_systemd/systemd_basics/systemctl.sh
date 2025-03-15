
# SERVICE in Linux is a program or daemon (background process) that runs in the background 
#     * perform essential tasks like serving web pages, handling logins, etc.
#     * services are typically managed by the init system, such as `systemd`, `SysVinit`, or `upstart`

systemctl                                # control the systemd system and service manager

# list all enabled services (check regularly)
systemctl list-unit-files --type=service --state=enabled

# status
systemctl status                         # show the status of specific service
systemctl list-units --type=service      # list all loaded services
systemctl is-active service              # check if specific service is active
systemctl is-enabled service

# start / stop / restart
systemctl start                          # start specific service
systemctl stop                           # stop specific service
systemctl restart                        # restart specific service so it pick up new settings (may interrupt other users)
systemctl reload                         # restart but more gentle (no interruptions)
systemctl reload-or-restart              # reload OR restart if reload is not supported by the app

# enable / disable
systemctl enable                         # enable a service to start at boot
systemctl is-enabled                     # checks if service is enabled
systemctl disable                        # disable a service from starting at boot
systemctl mask                           # masked services cannot be enabled or started
systemctl unmask

# --now: Applies enable/disable actions immediately without requiring a reboot.

systemctl cat sshd.service               # shows informations about ssh daemon: ExecStart, ExecReload, Restart 
systemctl edit --full sshd.service       # edit service
systemctl revert sshd.service            # revert changes of service edit

# unit file is a plain text that encodes information about a service, a socket, a device, amount point… etc.
# https://www.freedesktop.org/software/systemd/man/systemd.unit.html
