
awk     # pattern scanning and processing language
# NR  – the number of the current record (line number)
# OFS – output field separator (default is a space)
# FS  – input field separator (default is whitespace)

awk '{print $1}' file.txt                              # print the first field (column) of each line
awk -F':' '{aprint $1, $3}' /etc/passwd                # print the first and third fields of a colon-separated file
awk '/pattern/ {print $0}' file.txt                    # print lines matching a pattern
awk '{sum += $1} END {print sum}' file.txt             # sum the values in the first field and print the total
awk '{print NR, $0}' file.txt                          # print line numbers along with each line
awk -F, '{print $2, $3}' data.csv                      # print the second and third fields from a CSV file
awk 'length($0) > 80' file.txt                         # print lines longer than 80 characters
awk 'BEGIN {FS="\t"; OFS=","} {print $1, $2}' file.tsv # convert a tab-separated file to a comma-separated file
awk -F: '($3 >= 1000) {print $1}' /etc/passwd          # print usernames with UID greater than or equal to 1000
awk '{if ($1 > 50) print $0}' file.txt                 # print lines where the first field is greater than 50
