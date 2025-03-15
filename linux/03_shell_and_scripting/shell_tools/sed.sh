
sed     # stream editor for filtering and transforming text

# -e   – allows the execution of multiple editing commands
# -i   – edit files in place (modify the original file)
# s    – substitute command; used for search and replace
# g    – global flag; apply the substitution to all matches in a line
# p    – print the result of the command

sed 's/pattern/replacement/' file.txt                     # replace the first occurrence of 'pattern' with 'replacement'
sed 's/pattern/replacement/g' file.txt                    # replace all occurrences of 'pattern' with 'replacement'
sed -i 's/old/new/g' file.txt                             # replace all occurrences in place, modifying the original file
sed -n 's/pattern/replacement/p' file.txt                 # replace and print only lines where substitution occurred
sed -i 's/pattern/replacement/gi' file.txt                # /gi ignores case sensitivity
sed -i '500,2000s/pattern/replacement/gi'                 # Changes only in lines from 500 to 2000

# using regular Expressions
sed -E 's/[0-9]+/NUMBEr/g' file.txt                       # replace all sequences of digits with 'NUMBEr'
sed '2s/pattern/replacement/' file.txt                    # replace 'pattern' with 'replacement' only on line 2

# deleting Lines
sed '3d' file.txt                                         # delete the third line of the file
sed '/pattern/d' file.txt                                 # delete all lines containing 'pattern'

# inserting and appending Lines
sed '2i\inserted line' file.txt                           # insert a line before line 2
sed '2a\appended line' file.txt                           # append a line after line 2

# printing Specific Lines
sed -n '1,5p' file.txt                                    # print lines 1 to 5 of the file
sed -n '/pattern/p' file.txt                              # print lines containing 'pattern'
