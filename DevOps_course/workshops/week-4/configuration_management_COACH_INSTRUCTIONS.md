# Coach Instructions
It's going to help if you know Ansible, at least a little bit!

## Describe/explore (~5-10 mins)
The problem: We know how to make EC2 instances. Putting the right things on them is annoying though!

Let's say we wanted to use our knowledge of docker to deploy a set of containers together onto an EC2 instance - how would we do that?

- bake an image including docker
- manually log on once we've set the instance up? (good time to explain [Cattle vs pets](https://www.hava.io/blog/cattle-vs-pets-devops-explained))
- Configuration management tools (e.g. Ansible, Chef, Puppet)

## Demo (~20-30 mins)
Demonstrate the steps of the instructions up to running the test task.

The shell script sets up an *inventory* - a collection of servers which Ansible will work with

The command which starts with just "ansible" (not ansible-playbook) is an _ad hoc_ command.

You'll want to talk about the test task playbook, from "what's a playbook" and "what's YAML" to the parts of it.
```
- name: Test task                              # this is an entry in a list, here's its name
  hosts: all                                   # hosts can be grouped, are read from the inventory file (-i or --inventory)
  tasks:                                       # a list of tasks!
     - name: Leaving a mark                    # a list entry, with a name
       command: "touch /tmp/ansible_was_here"  # the command to run
```

It might be worth talking about what "idempotent" means - ideally each task will be idempotent

You probably also want to demonstrate the "Parson's problem" approach for the acebook deployment - the first entry in the element file goes with the <placeholder> already present in deploy-acebook.yml. (You should definitely do the parson's problem yourself sometime as prep - it's reasonably tough to work through.)

Talk through what each big block is trying to achieve, and why (copy files, npm install, set up the service)

## Practice (~45-60 mins)
Put the students in groups to work through the instructions including the deploy-acebook playbook

Extra (in case some are done very quickly and you need to slow them down a bit):
Change the way Acebook is deployed to use git and a deploy key

## Plenary/reflection

The usual how did it go / any questions
refer back to learning objectives

How could this tool have been useful last week?