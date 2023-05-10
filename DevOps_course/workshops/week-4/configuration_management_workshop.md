# Configuration Management Workshop
Finding out what configuration management is, and an intro to using Ansible alongside terraform

## Learning goals:
- Identify what configuration management tools are, and how they fit into the DevOps ecosystem
- Consolidate knowledge of terraform, by applying provided .tf scripts 
- Understand the parts of an ansible playbook and how they fit together to enable flexible deployment at scale

## Workshop instructions:
Install ansible using `python3 -m pip install ansible`

edit the terraform (ec2-instance.tf) to include the name of your private key

Apply the terraform in the tf/ folder

in the base folder for the workshop, run `./configuration-management-ansible-setup.sh`

(optional) You might want to set up INSTANCE_IP and PATH_TO_MY_KEY_PAIR_PRIVATE_KEY - that will enable you to just copy and paste the instructions below. There's a benefit to typing it out though - you just might want this to be part of your muscle memory!

Let's check we can connect to our instance using SSH: `ssh -i $PATH_TO_MY_KEY_PAIR_PRIVATE_KEY ec2-user@$INSTANCE_IP`

Our first Ansible command will be: `ansible all -m ping --inventory ansible-hosts --private-key $PATH_TO_MY_KEY_PAIR_PRIVATE_KEY`

You should see a response something like this:
```
63.35.209.7 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

Let's run an Ansible Playbook! (What's a Playbook?)
`ansible-playbook playbook/test-task.yml --inventory ansible-hosts --private-key $PATH_TO_MY_KEY_PAIR_PRIVATE_KEY`

This playbook simply makes a file called "ansible_was_here" in the /tmp/ directory of its' target. You should be able to ssh in and see that. (`ls /tmp`)

Let's build our own playbook - I've set up a start on a playbook at playbook/deploy-acebook.yml, and you can find everything else you need in blocks.txt and elements.txt in the same folder.

NB: You'll need to remove the node_modules folder from Acebook on your machine to deploy it - or you can clone Acebook into a different location just for this workshop. Ansible's built in copy command can be slow when it's working with lots of files, and will take about 5 minutes in any case.

Once you've completed your playbook, (or any time you want to see your progress) you can run it:
`ansible-playbook playbook/deploy-acebook.yml --inventory ansible-hosts --private-key $PATH_TO_MY_KEY_PAIR_PRIVATE_KEY`
If you're not sure your *Copy files* step is working, you can ssh into the machine from another terminal to see how it's progressing. Let your coach know if you're keen to try a different approach to get Acebook on to the machine!

once that's completed successfully, you can open Acebook:
`open http://$INSTANCE_IP:3000`

At the end of this session, we'll destroy the infrastructure we've created and deployed Acebook to: `terraform destroy`