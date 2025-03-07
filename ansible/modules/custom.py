#!/usr/bin/python
from ansible.module_utils.basic import AnsibleModule

def main():
    module = AnsibleModule(
        argument_spec={
            "name": {"type": "str", "required": True}
        }
    )
    name = module.params["name"]
    module.exit_json(changed=True, message=f"Hello, {name}!")

if __name__ == "__main__":
    main()
