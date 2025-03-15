# You have access to 5 servers:
  # terminal (default)
  # web-srv1
  # app-srv1
  # data-001
  # data-002
# The server on which to solve a question is mentioned in the question text. If no server is mentioned you'll need to create your solution on the default terminal
# If you're asked to create solution files at /opt/course/*, then always do this on your main terminal
# You can connect to each server using ssh, like ssh web-srv1
# All server addresses are configured in /etc/hosts on each server
# Nested ssh is not possible: you can only connect to each server from your main terminal
# It's not possible to restart single servers. If deeper issues or misconfigurations occurred then the only solution might be to restart the complete simulator. This is possible using top menu by selecting "Restart Session"
# This simulator might not contain all LFCS exam topics. Attendees are still required to learn and study the complete curriculum

---

### 1 Kernel and System Info
# Write the Linux Kernel release into /opt/course/1/kernel.
# Write the current value of Kernel parameter ip_forward into /opt/course/1/ip_forward.
# Write the system timezone into /opt/course/1/timezone.

## Step:1
uname -r > /opt/course/1/kernel
## Step:2
cat /proc/sys/net/ipv4/ip_forward > /opt/course/1/ip_forward  #The kernel parameter ip_forward is located in /proc/sys/net/ipv4/ip_forward
## Step:3
cat /etc/timezone > /opt/course/1/timezone
date +%Z > /opt/course/1/timezone
timedatectl | grep "Time zone" | awk '{print $3}' > /opt/course/1/timezone



### 2 CronJobs
# On server data-001, user asset-manager is responsible for timed operations on existing data. Some changes and additions are necessary.
# Currently there is one system-wide cronjob configured that runs every day at 8:30pm. Convert it from being a system-wide cronjob to one owned and executed by user asset-manager. 
# This means that user should see it when running crontab -l.
# Create a new cronjob owned and executed by user asset-manager that runs bash /home/asset-manager/clean.sh every week on Monday and Thursday at 11:15am.

## Step:1
# System-wide cron jobs are stored in /etc/crontab or /etc/cron.d
cat /etc/crontab
30 20 * * * root /path/to/your/script.sh # Remove this cronjob
# su asset-manager
# crontab -e
sudo -u asset-manager crontab -e # Switch to asset-manager user and open the crontab
30 20 * * * /path/to/your/script.sh

## Step:2
15 11 * * 1,4 bash /home/asset-manager/clean.sh # Step 2

sudo -u asset-manager crontab -l # Verify the changes



### 3 Time synchronisation Config
# Time synchronisation configuration needs to be updated:
#   1. Set 0.pool.ntp.org and 1.pool.ntp.org as main NTP servers
#   2. Set ntp.ubuntu.com and 0.debian.pool.ntp.org as fallback NTP servers
#   3. The maximum poll interval should be 1000 seconds and the connection retry 20 seconds

timedatectl

sudo vim /etc/systemcd/timesyncd.conf
ntpdate -q 0.de.pool.ntp.org # just query, don't update
ntpdate -q www.google.de # won't work

## Step:1 main servers
sudo vim /etc/systemd/timesyncd.conf
[Time]
NTP=0.pool.ntp.org 1.pool.ntp.org

## Step:2 fallback server
[Time]
NTP=0.pool.ntp.org 1.pool.ntp.org
FallbackNTP=ntp.ubuntu.com 0.debian.pool.ntp.org

## Step:3
[Time]
NTP=0.pool.ntp.org 1.pool.ntp.org
FallbackNTP=ntp.ubuntu.com 0.debian.pool.ntp.org
PollIntervalMaxSec=1000
ConnectionRetrySec=20

sudo service systemd-timesyncd restart 
sudo service systemd-timesyncd status
timedatectl status

sudo grep systemd-timesyncd /var/log/syslog



### 4 Environment Variables
# There is an existing env variable for user student@terminal: VARIABLE1=random-string, defined in file .bashrc. Create a new script under /opt/course/4/script.sh which:
#   1. Defines a new env variable VARIABLE2 with content v2, only available in the script itself
#   2. Outputs the content of the env variable VARIABLE2
#   3. Defines a new env variable VARIABLE3 with content ${VARIABLE1}-extended, available in the script itself and all child processes of the shell as well
#   4. Outputs the content of the env variable VARIABLE3

echo $VARIABLE1
env | grep VARIABLE
cat .bashrc | grep VARIABLE1

#!/bin/bash
# Define VARIABLE2, only available within the script
VARIABLE2="v2" # Define VARIABLE2, only available within the script
echo $VARIABLE2 # # Output the content of VARIABLE2
export VARIABLE3="${VARIABLE1}-extended" # # Define VARIABLE3, derived from the existing VARIABLE1 and available to child processes
echo $VARIABLE3 # # Output the content of VARIABLE3



### 5 Archives and Compression
# There is archive /imports/import001.tar.bz2 on server data-001. You're asked to create a new gzip compressed archive with its raw contents. Make sure the original archive will remain untouched.
# Store the new archive under /imports/import001.tar.gz. Compression should be the best possible, using gzip.
# To make sure both archives contain the same files, write a list of their sorted contents into /imports/import001.tar.bz2_list and /imports/import001.tar.gz_list.

## Possibility:1
# Extract bzip2 archive and recive uncompressed tar archive
bunzip2 -k import001.tar.bz2
ls -lh

# Every tar archive contains a 'tar' data layer
gzip --best import001.tar

## Possibility:2
# Completely extract and pack again
mkdir import001
tar xf import001.tar.bz2 -C import001
find import001/

GZIP=-9 tar czf import001.tar.gz -C import001 . # -9 is the maximum compression level
## OR
tar -I 'gzip -9' -cf import001.tar.gz -C import001 .
# -I 'gzip -9' explicitly specifies that gzip should be used with maximum compression

## Ensure archives contain the same files:
tar tf import001.tar.bz2 | sort > import001.tar.bz2_list
tar tf import001.tar.gz | sort > import001.tar.gz_list

# Compare the hashes
cat import001.tar.bz2_list | sha512sum
cat import001.tar.gz_list | sha512sum



### 6 User, Groups, Sudoers
# On server app-srv1:
#   1. Change the primary group of user user1 to dev and the home directory to /home/accounts/user1
#   2. Add a new user user2 with groups dev and op, home directory /home/accounts/user2, terminal /bin/bash
#   3. User user2 should be able to execute sudo bash /root/dangerous.sh without having to enter the root password

## Step:1
usermod -d /home/account/user1 user1
## OR
vim /etc/passwd
user1:x:1001:1001::/home/accounts/user1:/bin/bash # change path

su user1 # Verify
cd 
pwd 

usermod -g dev user1
groups user1 # Verify

## Step:2
useradd -h
useradd -s /bin/bash -m -d /home/accounts/user2 -G dev,op user2
cat /etc/group | grep user2 # Verify

## Step:3
visudo

user2 ALL=(root) NOPASSWD: /bin/bash /root/dangerous.sh # ADD THIS

su user2 # Verify
sudo bash /root/dangerous.sh



### 7 Network Packet Filtering
# Server data-002 is used for big data and provides internally used apis for various data operations. You're asked to implement network packet filters on interface eth0 on data-002:
#   1. Port 5000 should be closed
#   2. Redirect all traffic on port 6000 to local port 6001
#   3. Port 6002 should only be accessible from IP 192.168.10.80 (server data-001)
#   4. Block all outgoing traffic to IP 192.168.10.70 (server app-srv1)

curl data-002:{port}

ssh data-002
iptables -L
iptables -L -t nat
ip -a # We see eth0 interface and no existing iptables rules implemented

## Step:1
# Close port 5000 using iptables
iptables -A INPUT -i eth0 -p tcp --dport 5000 -j DROP
iptables -L

curl localhost:5000 # Test, still works
exis
curl data-001:5000 # blocked from remote

## Step:2
iptables -A PREROUTING -i eth0 -t nat -p tcp --dport 6000 -j REDIRECT --to-port 6001
iptables -L -t nat

## Step:3
iptables -A INPUT -i eth0 -p tcp --dport 6002 -s 192.168.10.80 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 6002 -j DROP
# First allow IP and then deny all other traffic on this port
curl data-002:6002 # fail
ssh data-001
curl data-002:6002 # works

## Step:4
nc app-srv1 22 # works
iptables -A OUTPUT -d 192.168.10.70 -p tcp -j DROP
nc app-srv1 22 # timeout
nc data-001 22 # works



### 8 Disk Management
# Your team selected you for this task because of your deep filesystem and disk/devices expertise. Solve the following steps to not let your team down:
#   1. Format /dev/vdb with ext4, mount it to /mnt/backup-black and create empty file /mnt/backup-black/completed
#   2. Find the fullest of the disks /dev/vdc and /dev/vdd. Then empty the .trash folder on it
#   3. There are two processes running: dark-matter-v1 and dark-matter-v2. Find the one that consumes more memory. Then unmount the disk where the process executable is located on

sudo fdisk -l
lsblk -f
df -h

## Step:1
sudo mkfs -t ext4 /dev/vdb
sudo mkdir /mnt/backup-black
sudo mount /dev/vdb /mnt/backup-black
sudo touch /mnt/backup-black/completed
df -h

## Step:2
df -h
sudo rm -rf /mnt/backup001/.trash/*
df -h

## Step:3
top -b | grep dark-matter
ps aux | grep dark-matter

df -h | grep /mnt/app-4e9d7ele
sudo umount /mnt/app-4e9d7ele # disk is busy so we have to kill the processes

sudo lsof | grep /mnt/app-4e9d7ele
sudo kill 6204 # PID of the process

sudo umount /mnt/app-4e9d7ele



### 9 Find files with properties
# There is a backup folder on server data-001 at /var/backup/backup-015, it needs to be cleaned up.
# First:
#   - Delete all files created before 01-01-2020
# Then for the remaining:
#   - Find all files smaller than 3KiB and move these to /var/backup/backup-015/small/
#   - Find all files larger than 10KiB and move these to /var/backup/backup-015/large/
#   - Find all files with permission 777 and move these to /var/backup/backup-015/compromised/

ssh data-001
cd /var/backup/backup-015
ls | grep backup | wc -l # 300

find ! -newermt "01/01/2020" -type f | wc -l # 21
find ! -newermt "01/01/2020" -type f -exec rm {} \; # delete for each
ls | grep backup | wc -l # 279 as 21 were deleted

find -maxdepth 1 -size -3k -type f | wc -l
find -maxdepth 1 -size -3k -type f -exec mv {} ./small \; # move

find -maxdepth 1 -size +10k -type f | wc -l
find -maxdepth 1 -size +10k -type f -exec mv {} ./large \; # move

find -maxdepth 1 -perm 777 -type f | wc -l
find -maxdepth 1 -perm 777 -type f -exec mv {} ./compromised \; # move

ls | grep backup | wc -l
ls small/ | wc -l # ...



### 10 SSHFS and NFS
# In this task it's required to access remote filesystems over network.
# On your main server terminal use SSHFS to mount directory /data-export from server app-srv1 to /app-srv1/data-export. The mount should be read-write and option allow_other should be enabled.
# The NFS service has been installed on your main server terminal. Directory /nfs/share should be read-only accessible from 192.168.10.0/24. On app-srv1, mount the NFS share /nfs/share to /nfs/terminal/share.

## SSHFS
man sshfs # always helpful
sudo mkdir -p /app-srv1/data-export
sudo sshfs -o allow_other,rw app-serv1:/data-export /app-srv1/data-export

find /app-srv1/data-export # Verify
touch /app-srv1/data-export/new # creating files work
find /app-srv1/data-export
ssh app-srv1 find /data-export # directories are synced

## NFS Server
service --help
service --status-all | grep nfs
service nfs-kernel-server status

sudo vim /etc/exports
/nfs/share            192.168.10.0/24(ro,sync,no_subtree_check,no_root_squash)

man exportfs
sudo exportfs -ra
showmount -e

## NFS Client
ssh app-srv1
nc -v terminal 2049 # debug
mkdir -p /nfs/terminal/share
mount terminal:/nfs/share /nfs/terminal/share # mount remote NFS export
find /nfs/terminal/share 
touch /nfs/terminal/share/new # not possible because read-only



### 11 Docker Management
# Someone overheard that you're a Containerisation Specialist, so the following should be easy for you! Please:
# 1. Stop the Docker container named frontend_v1
# 2. Gather information from Docker container named frontend_v2:
#     -Write its assigned ip address into /opt/course/11/ip-address
#     -It has one volume mount. Write the volume mount destination directory into /opt/course/11/mount-destination
# 3. Start a new detached Docker container:
#     -Name: frontend_v3
#     -Image: nginx:alpine
#     -Memory limit: 30m (30 Megabytes)
#     -TCP Port map: 1234/host => 80/container

sudo docker ps # list Docker containers

## Step:1
sudo docker stop frontend_v1
sudo docker ps -a # -a shows also stopped containers

## Step:2
sudo docker inspect frontend_v2 # docker inspect provides configuration in JSON format
sudo docker inspect frontend_v2 | vim - # for easier search

echo "172.17.0.3" >> /opt/course/11/ip-address
echo "/srv" >> /opt/course/11/mount-destination

## Step:3 
sudo docker run --help
sudo docker run -d --name frontend_v3 --memory 30m -p 1234:80 nginx:alpine

# in case of iptables error
sudo docker rm --force frontned_v3
sudo service docker restart

curl localhost:1234 # verify



### 12 Git Workflow
# You're asked to perform changes in the Git repository of the Auto-Verifier app:
# 1. Clone repository /repositories/auto-verifier to /home/student/repositories/auto-verifier.
# Perform the following steps in the newly cloned directory
# 2. Find the one of the branches dev4, dev5 and dev6 in which file config.yaml contains user_registration_level: open. Merge only that branch into branch main
# 3. In branch main create a new directory logs on top repository level. To ensure the directory will be committed create hidden empty file .keep in it
# 4. Commit your change with message added log directory

## Step:1
git clone /repositories/auto-verifier ~/repositories/auto-verifier 
cd ~/repositories/auto-verifier

## Step:2
git branch -a

git checkout dev4
grep user_registration_level config.yaml
... # for each branch
# OR
git checkout dev_5
git log # check commit tahat performed the change
git diff main 
# OR
git branch -a # compare from main to another branches
git diff origin/dev5

git checkout main
git merge dev5 # merge branch dev5 into main
grep user_registration_level config.yaml # verify

## Step:3
mkdir logs
ls -l 
touch logs/.keeep
git status

## Step:4
git add logs
git commit -m 'added log directory'



### 13 Runtime Security of processes
#There was a security alert which you need to follow up on. On server web-srv1 there are three processes: collector1, collector2, and collector3. It was alerted that any of these might run periodically the per custom policy forbidden syscall kill.
# End the process and remove the executable for those where this is true.

ssh web-srv1
ps aux | grep collector

strace -p 3611 # PID of first collector process
strace -p 3612 -e trace=kill
strace -p 3613

ps aux | grep collector2
kill 3613 # delete process colector2
ps aux | grep collector2
rm /bin/collector2 # remove the binary



### 14 Output redirection
# On server app-srv1 there is a program /bin/output-generator which, who would've guessed, generates some output. It'll always generate the very same output for every run:
# 1. Run it and redirect all stdout into /var/output-generator/1.out
# 2. Run it and redirect all stderr into /var/output-generator/2.out
# 3. Run it and redirect all stdout and stderr into /var/output-generator/3.out
# 4. Run it and write the exit code number into /var/output-generator/4.out

output-generator > /var/output-generator/1.out
output-generator 2> /var/output-generator/2.out
output-generator >> /var/output-generator/3.out 2>> /var/output-generator/3.out
output-generator
echo $? > /var/output-generator/4.out # get exit code and redirect to a file



### 15 Build and install from source
# Install the text based terminal browser links2 from source on server app-srv1. The source is provided at /tools/links-2.14.tar.bz2 on that server.
# Configure the installation process so that:
# 1. The target location of the installed binary will be /usr/bin/links
# 2. Support for ipv6 will be disabled

ssh app-srv1
cd /tools
ls 

tar xjf links-2.14.tar.bz2
cd links-2.14
ls -lh

# The usual process of installing from source is:
#   ./configure (args...)
#   make
#   make install

./configure --help
./configure --prefix /usr --without-ipv6

make

make install

whereis links # Verify
/usr/bin/links -version
/usr/bin/links -lookup ip6-localhost # error: host not found



### 16 LoadBalancer
# Server web-srv1 is hosting two applications, one accessible on port 1111 and one on 2222. These are served using Nginx and it's not allowed to change their config. The ip of web-srv1 is 192.168.10.60.
# Create a new HTTP LoadBalancer on that server which:
# - Listens on port 8001 and redirects all traffic to 192.168.10.60:2222/special
# - Listens on port 8000 and balances traffic between 192.168.10.60:1111 and 192.168.10.60:2222 in a Random or Round Robin fashion
# Nginx is already preinstalled and is recommended to be used for the implementation. Though it's also possible to use any other technologies (like Apache or HAProxy) because only the end result will be verified.

curl web-srv1:1111
curl web-srv1:2222
curl web-srv1:2222/special

## Nginx LoadBalancer
ssh web-srv1
cd /etc/nginx/sites-available
ls -lh
cat app1

cp app1 lb
vim lb
# server {
#         listen 8001 default_server;                           # change port
#         listen [::]:8001 default_server;                      # change port

#         server_name _;

#         location / {
#                 proxy_pass http://192.168.10.60:2222/special; # reverse proxy to the requsted url
#         }
# }

cd ../sites-enabled
ln -s ../sites-available/lb . # nginx way for enabling
service nginx restart
curl localhost:8001 # LB is reachable on port 8001

vim lb
### FIRST PART
# server {
#         listen 8001 default_server;
#         listen [::]:8001 default_server;

#         server_name _;

#         location / {
#                 proxy_pass http://192.168.10.60:2222/special; # reverse proxy to the requsted url
#         }
# }

### SECOND PART
# upstream backend {
#         # when no load balancing method is specified, Round Robin is used
#         server 192.168.10.60:1111; # app1
#         server 192.168.10.60:2222; # app2
# }

# server {
#         listen 8000 default_server;
#         listen [::]:8000 default_server;

#         server_name _;

#         location / {
#                 proxy_pass http://backend; # reverse proxy to the requsted url
#         }
# }

service nginx restart
exit 

curl web-srv:8000 # 'app1' and 'app2' randomly
curl web-srv:8001 # 'app2 special' alwasys
curl web-srv1:8001/anything/even/not/special # 'app2 special'



### 17 OpenSSH Configuration
# You need to perform OpenSSH server configuration changes on data-002. Users marta and cilla exist on that server and can be used for testing. Passwords are their username and shouldn't be changed. Please go ahead and:
#   1. Disable X11Forwarding
#   2. Disable PasswordAuthentication for everyone but user marta
#   3. Enable Banner with file /etc/ssh/sshd-banner for users marta and cilla

## Step:1
ssh data-002
vim /etc/ssh/sshd_config
# ...
# X11Forwarding no  # find and update to "no"
# ...

service ssh restart

## Step:2+3
vim /etc/ssh/sshd_config
# ...
# PasswordAuthentication no  # find and update to "no"
# ...
# # go to very end of the file and add:
# Match User marta
#   PasswordAuthentication yes
#   Banner /etc/ssh/sshd-banner

# Match User cilla
#   Banner /etc/ssh/sshd-banner

# It's important to add Match lines at the bottom of config file

service ssh restart
exit

ssh marta@data-002 # banner message; able to log in using password
exit
ssh cilla@data-002 # banner message; not able to log in using password
exit
ssh root@data-002 # no banner message



### 18 LVM Storage
# You're required to perform changes on LVM volumes:
#   1. Reduce the volume group vol1 by removing disk /dev/vdh from it
#   2. Create a new volume group named vol2 which uses disk /dev/vdh
#   3. Create a 50M logical volume named p1 for volume group vol2
#   4. Format that new logical volume with ext4

# PV = Physical Volume
# VG = Volume Group
# LV = Logical Volume

sudo pvs
sudo lvmdiskscan

## Step:1
sudo vgs # list all VGs
sudo vgreduce voll /dev/vdh
sudo vgs # verify
sudo pvs

## Step:2
sudo vgcreate vol2 /dev/vdh
sudo pvs

## Step:3
sudo lvs
sudo lvcreate --size 50M -name p1 vol2
sudo lvs

## Step:4
sudo mkfs -t ext4 /dev/vol2/pl

## Extending a mounted LV
sudo mkdir /mnt/vol2_p1
sudo mount /dev/vol2/p1 /mnt/vol2_p1
sudo lvs
sudo lvresize vol2/pl --size 70M # raise to 70M
sudo fdisk -l



### 19 Regex, filter out log lines
# On server web-srv1 there are two log files that need to be worked with:
#   1. File /var/log-collector/003/nginx.log: extract all log lines where URLs start with /app/user and that were accessed by browser identity hacker-bot/1.2. Write only those lines into /var/log-collector/003/nginx.log.extracted
#   2. File /var/log-collector/003/server.log: replace all lines starting with container.web, ending with 24h and that have the word Running anywhere in-between with: SENSITIVE LINE REMOVED

ssh web-srv1
cd /var/log-collector/003
ls -lha

## Step:1
cat nginx.log | grep "/app/user" | grep "hacker-bot/1.2" # not ideal

cat nginx.log | grep -E "/app/user.*hacker-bot/1.2" > nginx.log.extracted

## Step:2
cat server.log | grep -E "^container.web.*Running.*24h$"
cat server.log | grep -E "^container.web.*Running.*24h$" | wc -l
sed 's/^container.web.*Running.*24h$/SENSITIVE LINE REMOVED/g' server.log # test
sed 's/^container.web.*Running.*24h$/SENSITIVE LINE REMOVED/g' server.log | grep "SENSITIVE LINE REMOVED" | wc -l

cp server.log server.log.bak # backup
sed -i 's/^container.web.*Running.*24h$/SENSITIVE LINE REMOVED/g' server.log
cat /var/log-collector/003/server.log | grep 'SENSITIVE LINE REMOVED' | wc -l



### 20 User and Group limits
# User Jackie caused an issue with her account on server web-srv1. She did run a program which created too many subprocesses for the server to handle. A coworker of yours already solved it temporarily and limited the number of processes user jackie can run.
# For this the coworker added a command into .bashrc in the home directory of jackie. But the command just sets the soft limit and not the hard limit. Jackies password is brown in case needed.
# Configure the number-of-processes limitation as a hard limit for user jackie. Use the same number currently set as a soft limit for that user. Do it in the proper way, not via .bashrc.
# While at it you remember another ticket. On the same server you should enforce that group operators can only ever log in once at the same time.

## Step:1
ssh web-srv1
su jackie
cd
ulimit -a

if ! shopt -oq posix; then

# User could change the limit himself with
ulimit -S -u 1100
vim .bashrc #remove previous ulimit

vim /etc/security/limits.conf
# ...
# jackie         hard    nproc           1024     # add a new line

ulimit -u 
ulimit -S -u 1100 # user cannot modify limit

## Step:2
vim /etc/security/limits.conf
# ...
# jackie          hard    nproc           1024
# @operators      hard    maxlogins       1       # add this line

ssh jackie@web-srv1
su jackie #denied
