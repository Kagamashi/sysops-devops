# Secure Shell (SSH)

## Overview
SSH is a protocol for logging into remote machines and executing commands securely over an untrusted network. It provides encrypted communication between two hosts. OpenSSH is a widely used open-source implementation of the SSH protocol.

### File Transfer Methods:
- **SFTP (SSH File Transfer Protocol)**
- **SCP (Secure Copy)**

### Common SSH Options:
- `-A`: Enables forwarding of connections from the authentication agent (e.g., `ssh-agent`)
- `-i`: Specifies an identity file (private key)

### Basic Usage:
```bash
ssh username@remote_server
ssh -l username -p port address
```

---

## SSH Key Management

### `ssh-keygen`
The `ssh-keygen` command generates, manages, and converts authentication keys for SSH. Using SSH keys adds an extra layer of protection against hackers and brute-force attacks.

#### Key Options:
- `-b <bits>`: Specifies the number of bits for the key (e.g., 4096)
- `-C <comment>`: Adds a comment to the key
- `-f <file>`: Specifies the output file for the key
- `-p`: Changes or sets the passphrase
- `-t <type>`: Specifies the key type (e.g., `ed25519`)
- `-a <rounds>`: Sets the number of KDF rounds (e.g., 100 for `ed25519`)

#### Example:
```bash
ssh-keygen -t ed25519 -C "my-email" -b 4096
```

---

## SSH Configuration

SSH configuration files allow customization of connection options:
- **Command-line options**
- **User configuration file**: `~/.ssh/config`
- **System-wide configuration file**: `/etc/ssh/ssh_config`

### Common Configuration Parameters:
- `AddKeysToAgent`: Automatically adds keys to a running `ssh-agent`
- `UseKeychain`: On macOS, searches the user's keychain for passphrases
- `Host`: Specifies a nickname for the server
- `Hostname`: Specifies the actual hostname for logging in

Example `~/.ssh/config`:
```plaintext
Host bastion.example.com
  User carl

Host *.computer.internal
  ProxyJump bastion.example.com
  User carl
```

---

## Copying SSH Keys

### `ssh-copy-id`
The `ssh-copy-id` command logs into a remote machine and installs public keys to enable passwordless authentication. By default, it appends keys to `~/.ssh/authorized_keys` on the remote server.

#### Options:
- `-i <file>`: Specifies a file to copy
- `-n`: Dry run (prints keys that would be installed)

#### Example:
```bash
ssh-copy-id username@remote-server
```

---

## SSH Agent

### Overview
`ssh-agent` is a key manager for SSH that holds private keys in memory, allowing passwordless authentication without repeatedly typing a passphrase.

#### Starting the Agent:
```bash
eval "$(ssh-agent -s)"
exec ssh-agent bash
sudo -s -H
```

#### Adding Keys to the Agent:
```bash
ssh-add <private-key-file>
```

#### Options:
- `-l`: Lists fingerprints of all identities represented by the agent
- `-L`: Lists public key parameters
- `-d`: Removes a specific identity from the agent
- `-D`: Removes all identities
- `-A`: Enables agent forwarding for a single session
- `-x`: Locks the agent with a password
- `-X`: Unlocks the agent with a password

---

## ProxyJump

`ProxyJump` is a safer alternative to `ssh-agent` forwarding. It forwards the standard input and output of the local SSH client through a bastion host to the remote host.

#### Usage Example:
```bash
ssh -J bastion.example.com cloud.computer.internal
```

#### How It Works:
1. Connect to `bastion.example.com` using your local SSH client.
2. The SSH client uses keys from the agent to connect to the bastion host.
3. Once connected, the SSH daemon (SSHD) on the bastion connects to `cloud.computer.internal`.
4. Your local SSH client completes the handshake with `cloud.computer.internal`.

---

## Troubleshooting

### Common Errors and Fixes:
- **Error:** "Could not open a connection to your authentication agent."
  - **Solution:** Run `eval $(ssh-agent -s)` to start the agent.

- **Error:** "Permission denied (publickey)."
  - **Solution:** Add your public key to `~/.ssh/authorized_keys` on the remote server using `ssh-copy-id`.

- **Error:** Agent forwarding doesn't work with the `-A` option.
  - **Solution:** Ensure `AllowAgentForwarding yes` is set in `/etc/ssh/sshd_config` on the SSH server.

- **Error:** SSH agent does not persist between sessions.
  - **Solution:** Add the following to your shell profile (e.g., `~/.bashrc` or `~/.zshrc`):
    ```bash
    eval $(ssh-agent -s)
    ```

