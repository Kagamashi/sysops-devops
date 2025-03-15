
# modern Linux distirbutions using systemd rely on journal logs
# managed by journalctl

journalctl          # show all logs from systemd journal.
journalctl -xe      # show recent logs with details.
journalctl -f       # follow logs in real time.
journalctl -u sshd  # show logs for a specific service

journalctl --since "1 hour ago"         # view logs from the last hour.
journalctl --list-boots                 # list all boots and their corresponding log identifiers
journalctl -e                           # open journal and go to the end of the output
journalctl -p                           # show list of priority options: alert, crit, debug, emerg, err, info, notice, warning
journalctl -p info -g '^b'              # g is for grep
journalctl -S 01:00 -U 02:00            # logs recorded since specified time
journalctl -S '2024-10-10 10:10:55'     # logs recorded on specific date and time
journalctl -b 0                         # logs from current boot
journalctl -b 1                         # logs from previous boot

journalctl --disk-usage   # check disk usage

sudo journalctl --vacuum-time=7d    # clear old logs

# enable persistent logging (logs stored in /var/log/journal)
sudo mkdir -p /var/log/journal
sudo systemctl restart systemd-journald
