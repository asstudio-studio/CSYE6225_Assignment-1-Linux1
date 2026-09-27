#!/bin/bash
set -euo pipefail

PROJECT_DIR="/tmp/project"

# This starter script intentionally contains placeholder tasks.
# Replace each TODO block with the Linux commands needed to complete the assignment.

# 1. Create Directory Structure
# Create the main 'project' directory and its subdirectories: 'data', 'scripts', 'logs', and 'backup'.
echo "Creating directory structure..."
# TODO: create the required directories under "${PROJECT_DIR}"
mkdir -p "${PROJECT_DIR}"/{data,scripts,logs,backup}

# 2. File Operations
# In the 'data' directory, create five text files and add sample content to each.
echo "Creating files in the 'data' directory..."
# TODO: create file1.txt, file2.txt, file3.txt, file4.txt, and file5.txt in "${PROJECT_DIR}/data"
for i in 1 2 3 4 5; do
    echo "This is sample content for file${i}.txt" > "${PROJECT_DIR}/data/file${i}.txt"
done

# Copy 'file1.txt' to the 'backup' directory.
echo "Copying 'file1.txt' to 'backup' directory..."
# TODO: copy file1.txt into "${PROJECT_DIR}/backup"
cp "${PROJECT_DIR}/data/file1.txt" "${PROJECT_DIR}/backup/"

# Rename 'file3.txt' to 'file3_renamed.txt'.
echo "Renaming 'file3.txt' to 'file3_renamed.txt'..."
# TODO: rename file3.txt to file3_renamed.txt in the data directory
mv "${PROJECT_DIR}/data/file3.txt" "${PROJECT_DIR}/data/file3_renamed.txt"

# Move 'file4.txt' and 'file5.txt' to the 'logs' directory. Force the move to avoid prompts.
echo "Moving 'file4.txt' and 'file5.txt' to 'logs' directory..."
# TODO: move file4.txt and file5.txt into "${PROJECT_DIR}/logs"
mv -f "${PROJECT_DIR}/data/file4.txt" "${PROJECT_DIR}/data/file5.txt" "${PROJECT_DIR}/logs/"

# Delete 'file2.txt' from the 'data' directory.
echo "Deleting 'file2.txt' from 'data' directory..."
# TODO: delete file2.txt from the data directory
rm -f "${PROJECT_DIR}/data/file2.txt"

# 3. Directory Management
# List all files and directories within the 'project' directory with detailed information.
echo "Listing all files and directories with detailed information..."
# TODO: run a detailed listing of "${PROJECT_DIR}"
ls -laR "${PROJECT_DIR}"

# Display the total size of the 'data' and 'logs' directories.
echo "Displaying total size of 'data' and 'logs' directories..."
# TODO: show the combined size of "${PROJECT_DIR}/data" and "${PROJECT_DIR}/logs"
du -sh "${PROJECT_DIR}/data" "${PROJECT_DIR}/logs"

# Identify and display the 10 largest files and directories within the 'project' directory.
echo "Displaying the 10 largest files and directories in 'project'..."
# TODO: show the 10 largest items under "${PROJECT_DIR}"
du -ah "${PROJECT_DIR}" | sort -rh | head -n 10

# 4. File Permissions and Ownership
# Set specific file permissions 644 for 'file1.txt' in the 'backup' directory.
echo "Setting file permissions 644 for 'file1.txt'..."
# TODO: set permissions for "${PROJECT_DIR}/backup/file1.txt" to 644
chmod 644 "${PROJECT_DIR}/backup/file1.txt"

# Set specific file permissions 644 for 'file3_renamed.txt' in the 'logs' directory.
echo "Setting file permissions 644 for 'file3_renamed.txt'..."
# TODO: set permissions for "${PROJECT_DIR}/logs/file3_renamed.txt" to 644
chmod 644 "${PROJECT_DIR}/data/file3_renamed.txt"

# Change the ownership of 'file4.txt' in the 'logs' directory to another user and group (nobody:nogroup).
echo "Changing ownership of 'file4.txt'..."
# TODO: change ownership of "${PROJECT_DIR}/logs/file4.txt" to nobody:nogroup
chown nobody:nogroup "${PROJECT_DIR}/logs/file4.txt" 2>/dev/null || \
    sudo chown nobody:nogroup "${PROJECT_DIR}/logs/file4.txt" 2>/dev/null || \
    echo "Warning: could not change ownership (requires root privileges); skipping."
# For macOS system user to run correctly. GitHub Actions will run first line.

# 5. Symbolic Links
# Create a symbolic link in the 'scripts' directory pointing to 'backup/file1.txt' in the 'backup' directory.
echo "Creating symbolic link 'file1_link.txt' in 'scripts' directory..."
# TODO: create a symlink named file1_link.txt in "${PROJECT_DIR}/scripts" that points to ../backup/file1.txt
ln -sf ../backup/file1.txt "${PROJECT_DIR}/scripts/file1_link.txt"

# Manually verify that (use ls) the symbolic link has been created and points to the correct target.
echo "Verifying the symbolic link of file1.txt..."
# TODO: use ls or readlink to confirm the symlink target
ls -l "${PROJECT_DIR}/scripts/file1_link.txt"

# 6. System Monitoring and Process Management
# Display the disk usage of the entire filesystem.
echo "Displaying disk usage of the filesystem..."
# TODO: show filesystem disk usage
df -h

# List all running processes and specifically identify the process IDs related to Bash.
echo "Listing all running processes and finding PID of 'bash'..."
# TODO: list processes and filter for bash
ps aux | grep -i "[b]ash"

# 7. Automated Backup
# Create a compressed archive of the 'backup' directory and store it within the same directory.
# Use the current date to name the archive file.
echo "Creating a compressed archive of the 'backup' directory..."
# TODO: create a dated archive of "${PROJECT_DIR}/backup" inside "${PROJECT_DIR}/backup"
ARCHIVE_NAME="backup_$(date +%Y%m%d).tar.gz"
TMP_ARCHIVE="$(mktemp)"
tar -czf "${TMP_ARCHIVE}" -C "${PROJECT_DIR}" backup
mv "${TMP_ARCHIVE}" "${PROJECT_DIR}/backup/${ARCHIVE_NAME}"

# 8. Log Completion
# Create a log message indicating the completion of the assignment tasks and store it in a 'README.md' file inside the 'project' directory.
echo "Logging completion message..."
# TODO: write a one-line completion message to "${PROJECT_DIR}/README.md"
echo "Assignment completed on $(date '+%Y-%m-%d %H:%M:%S')." > "${PROJECT_DIR}/README.md"

# 9. Directory Existence Verification
# Add a verification step at the end of the script to check if the 'data' directory exists. If it doesn’t, the script should log an error message and exit.
echo "Verifying final directory state..."
# TODO: confirm that "${PROJECT_DIR}/data" exists; if not, print an error and exit
if [ -d "${PROJECT_DIR}/data" ]; then
    echo "Verification passed: '${PROJECT_DIR}/data' exists."
else
    echo "ERROR: '${PROJECT_DIR}/data' does not exist." >&2
    exit 1
fi
