## Version Constraints in Terraform

- **Exact Version:**
  ```hcl
  version = "=1.3.0"
  ```
  - Restricts usage to exactly `1.3.0`.

  ```hcl
  version = "!= 3.0.0"
  ```
  - Excludes version `3.0.0`. Do not use this version.

- **Version Range:**
  ```hcl
  version = ">1.2.0, <2.0.0, != 1.4.0"
  ```
  - Accepts versions between `1.2.0` and `2.0.0`, excluding `1.4.0`.

- **Pessimistic Constraint (~>):**
  ```hcl
  version = "~> 1.2"
  ```
  - Accepts versions `1.2.x` but excludes versions `1.3.0` and above.

- **Wildcard Matching (*):**
  ```hcl
  version = "*"
  ```
  - Matches any version. **Not recommended** for production environments.

- **Caret Constraint (^):**
  ```hcl
  version = "^1.2.3"
  ```
  - Matches `1.2.3`, `1.3.0`, `1.4.5`, etc., but excludes `2.0.0`.
