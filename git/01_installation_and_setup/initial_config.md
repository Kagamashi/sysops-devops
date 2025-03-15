# Initial Git Configuration

## Setting Name and Email

Git requires you to configure your identity before making commits:

```sh
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

To check your configuration:

```sh
git config --list
```

## Aliases

Git allows you to create shortcuts for frequently used commands:

```sh
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
```

To see all configured aliases:

```sh
git config --get-regexp alias
```

## Global .gitignore Usage

A global `.gitignore` file can be used to exclude common files across all repositories:

1. Create the file:
   ```sh
   touch ~/.gitignore_global
   ```
2. Add patterns to ignore, e.g.:
   ```
   *.log
   *.swp
   .DS_Store
   ```
3. Configure Git to use this file:
   ```sh
   git config --global core.excludesfile ~/.gitignore_global
   ```

## Default Branch Name

By default, Git initializes repositories with the `main` branch. You can change this:

```sh
git config --global init.defaultBranch main
```

## Understanding `.gitconfig`

Git stores configuration settings in different scopes:

- **System-wide** (`/etc/gitconfig`)
  - Applies to all users and repositories on the system.
  - Modify using:
    ```sh
    sudo git config --system <key> <value>
    ```

- **Global** (`~/.gitconfig` or `~/.config/git/config`)
  - Applies to the current user.
  - Modify using:
    ```sh
    git config --global <key> <value>
    ```

- **Local** (`.git/config` inside a repository)
  - Applies only to a specific repository.
  - Modify using:
    ```sh
    git config --local <key> <value>
    ```

To view configurations at different levels:

```sh
git config --list --system
git config --list --global
git config --list --local 
```

---
