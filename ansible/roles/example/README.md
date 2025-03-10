Role Name
=========
 
Role Name
=========
 
This is a role created for demonstration purposes that configures a basic nginx webserver with a minimal configuration.
 
Requirements
------------
 
Any prerequisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.
 
* Ansible
* Jinja2
 
Role Variables
--------------
 
A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.
 
### defaults/main.yml
Default nginx installation variables.
 
* nginx_version: Specific version of nginx to install
* nginx_custom_directory: Custom directory for nginx installation
 
### vars/main.yml
Here we define variables that have high precedence and aren't intended to be changed by the play.
 
* nginx_custom_directory: Custom directory for nginx installation
 
Dependencies
------------
 
A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.
 
Example Playbook
----------------
 
Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
 
   - hosts: all
     become: true
     roles:
       - webserver
 
License
-------
 
Apache-2.0
 
Author Information
------------------
 
Mikolaj Borecki
