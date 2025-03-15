# used to quickly find files
# it relies on mlocate.db database

locate [options] filename

locate file.txt	    #Finds all files named file.txt on the system.
locate -i file.txt	# Case-insensitive search for file.txt.
locate -c filename	# Counts the number of matches found.
locate -n 10 filename	  # Limits output to 10 results.
locate '*.log'	    # Finds all .log files on the system.
locate -b '\file.txt'	    # Finds file.txt but not /path/to/file.txt (matches only base filename).
locate -e filename	      # Only shows existing files (ignores deleted files in the database).
