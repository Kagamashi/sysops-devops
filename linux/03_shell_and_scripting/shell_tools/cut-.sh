
# cut extracts specific columns or fields from a file or input

cut -d',' -f1 file.csv     # Extract the first column (fields separated by commas)
cut -c1-5 file.txt         # Extract the first 5 characters from each line
cut -f2 file.tsv           # Extract the second field (tab-separated values)