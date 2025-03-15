# ShellCheck
https://github.com/koalaman/shellcheck

## Overview
ShellCheck is a static analysis tool for shell scripts.
- Detects syntax errors and warnings
- Provides recommendations for POSIX compliance
- Highlights potential security risks in scripts
- Suggests fixes for best practices

### Installation:
#### On Debian/Ubuntu:
```bash
sudo apt-get install shellcheck
```

#### From Source:
1. Clone the repository:
   ```bash
   git clone https://github.com/koalaman/shellcheck.git
   ```
2. Build and install:
   ```bash
   cd shellcheck
   cabal install
   ```

### Basic Usage:
```bash
shellcheck script.sh
```

### Common Options:
- `-f <format>`: Specifies the output format (e.g., `gcc`, `json`)
- `-e <code>`: Excludes specific error codes
- `-s <shell>`: Specifies the shell dialect (e.g., `bash`, `sh`, `ksh`)
- `-a`: Enables warning for all checks
- `-x`: Follows source directives

### Example:
```bash
shellcheck -s bash -f gcc script.sh
```
