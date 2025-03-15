#!/bin/bash
# Utility script to quickly import Azure role assignments into Terraform

# --- Configuration ---
roles=("Virtual Machine User Login" "Contributor" "Reader")  # Add more roles as needed
tf_id_prefix='put_here_the_terraform_prefix'  # Terraform resource prefix
scope='put_resource_id_here'                  # Default scope (can be overridden)

# --- Flags ---
DRY_RUN=0
VERBOSE=0

# --- Functions ---

# Print usage information
usage() {
  echo "Usage: $0 [-s scope] [-d] [-v]"
  echo "  -s scope       Specify the scope (resource ID) for the role assignments."
  echo "  -d             Dry run mode (no actual imports, only display actions)."
  echo "  -v             Verbose mode (detailed output)."
  echo "  -h             Show this help message."
}

# Log messages when verbose mode is enabled
log_verbose() {
  if [ "$VERBOSE" -eq 1 ]; then
    echo "[INFO] $1"
  fi
}

# Log errors
log_error() {
  echo "[ERROR] $1" >&2
}

# Process role assignments
process_role_assignments() {
  local roleName="$1"
  for u in "${users[@]}"; do
    echo "Processing user: ${u} for role: ${roleName}"
    
    # Get the assignment ID
    assignment_id=$(az role assignment list --scope "${scope}" --role "${roleName}" --assignee "${u}" --query '[].id' -o tsv)

    # Check if the assignment ID was found
    if [ -z "$assignment_id" ]; then
      log_error "No assignment found for user ${u} with role ${roleName}. Skipping..."
      continue
    fi

    # Determine the Terraform import command
    tf_import_cmd="terraform import \"${tf_id_prefix}[\\\"${u}\\\"]\" \"${assignment_id}\""

    # Dry run or actual import
    if [ "$DRY_RUN" -eq 1 ]; then
      echo "[DRY RUN] Would execute: $tf_import_cmd"
    else
      log_verbose "Executing: $tf_import_cmd"
      eval "$tf_import_cmd"
      if [ $? -ne 0 ]; then
        log_error "Failed to import assignment for user ${u} with role ${roleName}."
      else
        log_verbose "Successfully imported assignment for user ${u} with role ${roleName}."
      fi
    fi
  done
}

# --- Main Script ---

# Parse command-line options
while getopts "s:dvh" opt; do
  case $opt in
    s)
      scope=$OPTARG
      ;;
    d)
      DRY_RUN=1
      ;;
    v)
      VERBOSE=1
      ;;
    h)
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

# Check if scope is provided
if [ -z "$scope" ]; then
  log_error "Scope is not specified. Use the -s option to set the scope."
  exit 1
fi

# Confirmation prompt
read -p "Are you sure you want to import role assignments for scope ${scope}? (y/n): " confirm
if [[ "$confirm" != [yY] ]]; then
  echo "Operation cancelled."
  exit 0
fi

# List of users to process
users=( \
  "user1@example.com" \
  "user2@example.com" \
  # Add more users as needed
)

# Process each role for all users
for role in "${roles[@]}"; do
  echo "Processing role: ${role}"
  process_role_assignments "$role"
done

echo "Script execution completed."
