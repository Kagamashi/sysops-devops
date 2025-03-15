
# uniq command filters out duplicate lines from sorted input

uniq file.txt             # Remove consecutive duplicate lines
sort file.txt | uniq      # Sort first, then remove duplicates
uniq -c file.txt          # Count occurrences of each unique line

# [!] uniq only removes consecuutive duplicates - use sort before uniq to remove all duplicates
