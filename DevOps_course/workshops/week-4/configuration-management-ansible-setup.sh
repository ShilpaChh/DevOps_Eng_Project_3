#!/bin/sh
GROUP=$(cat tf/terraform.tfstate | grep Group | head -1 | sed -n "s/.*\([0-9a-f]\{8\}\).*/\1/p")
echo "Group ID is $GROUP"

INSTANCE_IP=$(cat tf/terraform.tfstate | grep \"public_ip\": | head -1 | sed -n "s/.*\"\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)\".*/\1/p")
echo "Instance IP is $INSTANCE_IP"

echo $INSTANCE_IP ansible_connection=ssh ansible_user=ec2-user > ./ansible-hosts
