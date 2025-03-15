
# most useful
grep -c "ERROR" /var/log/syslog  # Count occurrences of 'ERROR'
grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" /var/log/syslog | sort | uniq -c | sort -nr  # Count unique IPs
grep -o "word" file.txt | wc -l  # Count occurrences of 'word'
grep -i "error" /var/log/syslog  # Find all occurrences of 'error' (case insensitive)

# globbing
ls -l a*      # * # every character
ls -l a?      # ? # every single character
ls -l a[ab]   # [ab] # list of characters
ls -l a[a-c]  # [a-c]
ls -l a[a-c]* # wildcards can be combined

# REGEX : regular expressions
^     # line begins with
$	    # line ends with 
.	    # match any ONE character (except newline)
\	    # escaping for special characters
*	    # match the previous element 0 or more times
+	    # match the previous element 1 or more time
{}	  # previous element can exist "this many" times
?	    # make the previous element optional
|	    # match one thing or the other
[]	  # ranges or sets [a-z][0-9][abz954]
()	  # subexpressions 
(...) # group of characters (abc){2}
[^]	  # negated ranges or sets


grep    # Search for patterns in files

grep 'pattern' file.txt                     # search for 'pattern' in file.txt
grep -i 'pattern' file.txt                  # case-insensitive search for 'pattern'
grep -v 'pattern' file.txt                  # show lines that do not contain 'pattern' (inverted)
grep -r 'pattern' /path/to/directory        # recursively search for 'pattern' in a directory
grep -n 'pattern' file.txt                  # show line numbers along with matching lines
grep -l 'pattern' *.txt                     # list files in the current directory containing 'pattern'
grep -o 'pattern' file.txt                  # show only the matched parts of a line
grep -c 'pattern' file.txt                  # count the number of matching lines
grep -wi 'pattern' file.txt                 # match only word 'pattern', not bigger words with 'pattern' in them
grep -oi 'pattern' file.txt                 # only words --only-matching

grep -E 'pattern1|pattern2' file.txt        # extended regex to search for multiple patterns
egrep -w '[A-Z][a-z]{2}'

grep -v '^#' file             # lists only lines that are not comments
grep '^PASS' /etc/login.defs  # lists only PASS lines

grep '7$' file
grep 'mail$' file

grep -r 'c.t' /etc/  # will match cat, cut etc...

grep '\.' file    # will look for dots .

grep -r '/.*/' /etc/  # begins with / has 0 or more characters between and ends with /

grep -r '0+' /etc/    # lines with at least one '0'

egrep -r '0{3,}' /etc/    # 3+ '0' next to each other
egrep -r '10{,3}' /etc/   # '1' + 0 to 3 occurences of '0'
egrep -r '0{3}' /etc/     # exactly 3 occurences of 0

egrep -r 'disabled?' /etc/  # show disable, disabled, disables etc...

egrep -ir 'enabled?|disabled?' /etc/  # shows enabled or disabled (with the last element being optional)

egrep -r 'c[au]t' /etc/   # shows cat AND cut
egrep -r '/dev/[a-z]*' /etc/
egrep -r '/dev/[a-z]*[0-9]?' /etc/ # ? at the end to match entries ending not only with numbers

egrep -r '/dev/([a-z]*[0-9]?)*'                 # shows directories starting with /dev/ and then consisting of different combinations of characters and digits
egrep -r '/dev/(([a-z]|[A-Z])*[0-9]?)*' /etc/   # the same but also includes uppercase letters (but it can be either all lowercase or all uppercase)

egrep -r 'http[^s]' /etc/                   # exclude https
egrep -r '/[^a-z]' /etc/                    # only uppercase letters
