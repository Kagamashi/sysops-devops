
## Windows
1. Download Git for Windows from [git-scm.com](https://git-scm.com/download/win).
2. Run the installer and follow the setup wizard.
3. Choose the default settings unless you have specific preferences.
4. Verify the installation:
   ```sh
   git --version
   ```

## macOS
### Using Homebrew (Recommended)
1. Install Homebrew if not already installed:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install Git:
   ```sh
   brew install git
   ```
3. Verify the installation:
   ```sh
   git --version
   ```

## Linux
### Debian/Ubuntu
```sh
sudo apt update && sudo apt install git -y
```


## Post-Installation Configuration
Set up user information:
```sh
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Check configuration:
```sh
git config --list
```

To set a default branch name (optional):
```sh
git config --global init.defaultBranch main
```

To configure Git to store credentials:
```sh
git config --global credential.helper store
```

---
