
# tail command prints the last N lines of a file (default: 10 lines).

tail file.txt            # Show last 10 lines
tail -n 20 file.txt      # Show last 20 lines
tail -f logfile.log      # Continuously monitor a log file

# Tip: Use tail -f for real-time log monitoring.
tail -f /var/log/syslog  # Follow system logs live
tail -n 100 /var/log/syslog  # Display the last 100 lines 
