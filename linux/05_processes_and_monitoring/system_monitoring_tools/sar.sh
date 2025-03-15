
# sar collects and reports system resource usage over time
sudo systemctl enable --now sysstat

sar -u 5 10   # Show CPU usage every 5 seconds for 10 iterations.
sar -r        # Display memory usage statistics.
sar -d        # Show disk activity.
