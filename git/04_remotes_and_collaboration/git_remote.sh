
# A remote repository is a version of your project that is hosted on a remote server (e.g., GitHub, GitLab, Bitbucket).
# git remote allows you to manage connections to these remote repositories.

# add remote repository
git remote add [remote_name] [repository_url]
git remote add origin https://github.com/user/repo.git # origin is the default name given to the remote repository

# list remote repositories
git remote -v

# remove remote repository
git remote remove [remote_name]
