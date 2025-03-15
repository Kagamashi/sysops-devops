# Git submodules
Allow to include and track another Git repository inside our main Git repository
Useful when we want to keep separate repositories for different components but track them together in larger project

1. ADD SUBMODULE
Clone module into specified path and track it within our main repository
> git submodule add [repository_url] [path]
> git submodule add https://github.com/example/repo.git submodules/repo


2. CLONE REPOSITORY WITH SUBMODULES
When cloning repository containing submodules we also need to initialize and update the submodules
> git clone <repository_url>
> cd <repository>
> git submodule init
> git submodule update

Or in one command:
> git clone --recurse-submodules <repository_url>


3. UPDATING SUBMODULES
Update all submodules to their latest commit:
> git submodule update --remote

Update specific submodules by navigating to the submodule directory:
> cd <submodule_path>
> git pull


4. COMMIT CHANGES TO SUBMODULE
> git add <submodule_path>
> git commit -m "Update submodule to latest version"


5. REMOVE A SUBMODULE
> git submodule deinit -f <submodule_path>
> rm -rf .git/modules/<submodule_path>
> git rm -f <submodule_path>

---

## .gitmodules
Contains informations about all submodules used by the repository

[submodule "submodules/repo"]
    path = submodules/repo
    url = https://github.com/example/repo.git
    branch = main

---

## Reference TF MODULE from another repo

source = "git::git@ssh.dev.azure.com:v3/lhg-ddl/Digital%20Core%20Platform/<NASZE_REPO_Z_MODUŁAMI>//<NAZWA_KATALOGU_W_REPO_Z_MODULAMI>?ref=<NASZ_BRANCH/TAG>" 

source = "git::git@ssh.dev.azure.com:v3/lhg-ddl/Digital%20Core%20Platform/DCP-terraform-modules//key_vault?ref=feature/lk" 
