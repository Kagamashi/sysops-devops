The only criteria are that hooks must be stored in the .git/hooks folder in the repo root. 

.git/hooks is not pushed to the source code
can be mapped to a folder that can be then commited into source control (to share the scripts)
Git config --global core.hooksPath '~/.githooks'

if we need to overwrite git hooks
Git commit --no-verify

Also, they must be named to match the related events (Git 2.x):

applypatch-msg
pre-applypatch
post-applypatch
pre-commit
prepare-commit-msg
commit-msg
post-commit
pre-rebase
post-checkout
post-merge
pre-receive
update
post-receive
post-update
pre-auto-gc
post-rewrite
pre-push


# pre-commit : blocks commit if blocked words are found in the files
#!C:/Program\ Files/Git/usr/bin/sh.exe
matches=$(git diff-index --patch HEAD | grep '^+' | grep -Pi 'password|secret')
if [ ! -z "$matches" ]
then
  cat <<\EOT
Error: Words from the blocked list were present in the diff:
EOT
echo $matches
exit 1
fi

# prepend commit name with current branch name
#!C:/Program\ Files/Git/usr/bin/sh.exe
# Get the current branch name
branch_name=$(git branch --show-current)
# Check if the commit message file exists
if [[ -f "$1" ]]; then
  # Prepend the branch name to the commit message
  sed -i "1s/^/$branch_name: /" "$1"
fi


# post-commit : send e-mail notification
#!C:/Program\ Files/Git/usr/bin/sh.exe
# Set the recipient email address
$recipient="your@email.com"
# Set the subject of the email
$subject="Git Commit Notification"
# Set the body of the email
$body="A new commit has been made to the repository."
# Send the email notification
Send-MailMessage -To $recipient -Subject $subject -Body $body -SmtpServer "your.smtp.server"