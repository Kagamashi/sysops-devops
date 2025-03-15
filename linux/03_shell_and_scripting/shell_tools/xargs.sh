
# xargs command builds and executes commands using standard input.

echo "file1 file2 file3" | xargs rm        # Delete multiple files from input
ls *.log | xargs tar -cvf logs.tar         # Archive log files into a tarball
find . -name "*.txt" | xargs grep "error"  # Search for "error" in all .txt files

# Tip: Use -I{} to specify a placeholder for processing each argument:
echo "file1 file2" | xargs -I{} mv {} /backup/

