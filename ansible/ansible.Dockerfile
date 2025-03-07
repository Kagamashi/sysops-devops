FROM python:3.9
RUN pip install ansible
WORKDIR /ansible
COPY . .
CMD ["ansible-playbook", "-i", "inventory.ini", "site.yml"]
