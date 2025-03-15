
## **Using Systemd Timers (Cron Alternative)**

Systemd timers schedule recurring tasks (similar to `cron`).

### **Creating a Timer for a Script**
1. Create a systemd service file (`/etc/systemd/system/myscript.service`):
   ```plaintext
   [Unit]
   Description=Run My Script
   
   [Service]
   ExecStart=/usr/local/bin/myscript.sh
   ```

2. Create a timer unit (`/etc/systemd/system/myscript.timer`):
   ```plaintext
   [Unit]
   Description=Run My Script Every 10 Minutes
   
   [Timer]
   OnBootSec=5m
   OnUnitActiveSec=10m
   
   [Install]
   WantedBy=timers.target
   ```

3. Enable and start the timer:
   ```bash
   sudo systemctl enable myscript.timer
   sudo systemctl start myscript.timer
   ```
4. Check the timer status:
   ```bash
   systemctl list-timers
   ```

---
