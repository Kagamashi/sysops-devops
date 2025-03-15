## **2. Custom Package Repositories**
Organizations can create custom package repositories to distribute internal packages.

### **Creating a Custom RPM Repository**
1. Install `createrepo`:
   ```bash
   sudo dnf install createrepo
   ```
2. Create a repository directory and copy RPMs:
   ```bash
   mkdir -p /var/www/html/repo
   cp *.rpm /var/www/html/repo/
   ```
3. Generate repository metadata:
   ```bash
   createrepo /var/www/html/repo
   ```
4. Configure clients to use the custom repository by creating `/etc/yum.repos.d/custom.repo`:
   ```plaintext
   [customrepo]
   name=Custom Repo
   baseurl=http://your-server/repo/
   enabled=1
   gpgcheck=0
   ```

### **Creating a Custom DEB Repository**
1. Install `dpkg-dev`:
   ```bash
   sudo apt install dpkg-dev
   ```
2. Create a repository directory and copy DEB packages:
   ```bash
   mkdir -p /var/www/html/deb-repo
   cp *.deb /var/www/html/deb-repo/
   ```
3. Generate repository metadata:
   ```bash
   cd /var/www/html/deb-repo
   dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
   ```
4. Configure clients to use the custom repository by adding a line in `/etc/apt/sources.list`:
   ```plaintext
   deb [trusted=yes] http://your-server/deb-repo/ ./
   ```

---
