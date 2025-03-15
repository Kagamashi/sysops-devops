
# [modern alternative is systemd timers]

# CRON JOBS
#   * allows users to schedule tasks (commands or scripts) to run automatically at specific intervals
#   * on most systems cron logs are written to syslog
#   * the configuration for cron jobs is stored in "crontab" files, and each user can have their own crontab file.

crontab -l                            # display current user's cron jobs
sudo crontab -l                       # crontab of ROOT user
crontab -e                            # edit current user's crontab (opens in the default text editor)
crontab -r                            # remove all cron jobs for the current user
sudo crontab -e -u jane               # see crontab of specified user

# System-wide cron jobs are stored in the following directories:
#   * /etc/crontab              # system-wide crontab file
#   * /etc/cron.daily/          # scripts to be run daily
#   * /etc/cron.weekly/         # scripts to be run weekly
#   * /etc/cron.monthly/        # scripts to be run monthly
#   * /etc/cron.hourly/         # scripts to be run hourly

# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 7) (Sunday is 0 or 7)
# │ │ │ │ │
# * * * * * command_to_execute

* * * * * /path/to/command.sh          # every minute
0 0 * * * /path/to/command.sh          # daily at 00:00 (midnight.
30 14 * * * /path/to/command.sh        # daily at 14:30 (2:30 PM)
0 0 * * 0 /path/to/command.sh          # every Sunday at midnight
*/5 * * * * /path/to/command.sh        # every 5 minutes
0 0 1 * * /path/to/command.sh          # on the 1st of every month at midnight
15 3 * * 1 /path/to/command.sh         # every Monday at 03:15
0 */6 * * * /path/to/command.sh        # every 6 hours (at 00:00, 06:00, 12:00, and 18:00)

@reboot    /path/to/command.sh         # at system startup (once at boot)
@daily     /path/to/command.sh         # once every day at midnight
@weekly    /path/to/command.sh         # once every week (at midnight on Sunday)
@monthly   /path/to/command.sh         # once a month (at midnight on the 1st of the month)
@yearly    /path/to/command.sh         # once a year (at midnight on January 1st)

# * match all possible values (i.e. every hour)
# , match multiple values (i.e. 15,45)
# - range of values (i.e. 2-4)
# / specifies steps (i.e. */4)

0 2 * * * /home/user/backup.sh                                     # run a backup script every day at 2 AM
0 9 * * 1 echo "Weekly Report" | mail -s "Report" user@example.com # send an email every Monday at 9 AM
0 0 * * * rm -rf /tmp/*                                            # clear temporary files every day at midnight
0 3 15 * * /home/user/midmonth_script.sh                           # run a script at 3 AM on the 15th of every month
0 3 * * 0 apt update && apt upgrade -y                             # run a system update every Sunday at 3 AM
*/10 * * * * /usr/bin/python3 /home/user/script.py                 # run a Python script every 10 minutes


# define environment variables in your crontab:
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MAILTO=user@example.com                            # email any cron output to this address
HOME=/home/user                                    # set the home directory for commands


# ANACRON
#   * similar to cron but is used for systems that are not running 24/7
#   * it ensures that missed jobs are executed when the system is next powered on
#   * cannot schedule tasks more frequently than once per day
#   * configuration file: /etc/anacrontab

# period  delay  job-id  command
1         5      cron.daily  run-parts /etc/cron.daily   # runs daily jobs with a 5-minute delay after startup
7         10     cron.weekly run-parts /etc/cron.weekly  # runs weekly jobs with a 10-minute delay


# PERMISSIONS
# Users may be restricted from using cron if their name appears in the "/etc/cron.deny" file.
# Conversely, if a user's name appears in "/etc/cron.allow", they are permitted to use cron, even if they are in "/etc/cron.deny".

# Example: Add user "john" to allow cron usage
echo "john" >> /etc/cron.allow


# AT
at now + 1 minute                             # run the job one minute from now
at now + 2 hours                              # run the job two hours from now
at midnight                                   # run the job at midnight today
at noon                                       # run the job at noon today
at teatime                                    # run the job at 4 PM today
at 10:30                                      # run the job at 10:30 AM today
at 14:00                                      # run the job at 2 PM today
at 10:30 tomorrow                             # run the job at 10:30 AM tomorrow
at 10:30 next Friday                          # run the job at 10:30 AM on the next Friday
at 10:30 July 20                              # run the job at 10:30 AM on July 20 of this year
at 10:30 2024-12-31                           # run the job at 10:30 AM on December 31, 2024

atq                                          # lists all pending jobs for the current user
# 2  Thu Dec 30 10:30:00 2024 a user
# 3  Fri Jul 15 14:00:00 2024 a user

atrm <job_number>                            # remove the job with the specified job number
atrm 2                                       # removes job number 2 from the job queue

echo "rm -rf /tmp/*" | at midnight           #  schedule a disk cleanup job to run at midnight
