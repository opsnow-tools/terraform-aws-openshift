#!/usr/bin/env bash

set -x

# Elevate priviledges, retaining the environment.
sudo -E su

curl -s http://repo.toast.sh/helper/slack.sh | \
 bash -s -- --token=T03FUG4UB/B8RQJGNR0/U7LtWJKf8E2gVkh1S1oASlG5 Install: bastion $(hostname)

# Install dev tools.
yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel

# Get the OpenShift 3.9 installer.
pip install -I ansible==2.4.3.0
git clone -b release-3.9 https://github.com/openshift/openshift-ansible

# Get the OpenShift 3.7 installer.
# pip install -Iv ansible==2.4.1.0
# git clone -b release-3.7 https://github.com/openshift/openshift-ansible

# Get the OpenShift 3.6 installer.
# pip install -Iv ansible==2.3.0.0
# git clone -b release-3.6 https://github.com/openshift/openshift-ansible

# Run the playbook.
ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/prerequisites.yml
ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/deploy_cluster.yml

# If needed, uninstall with the below:
# ansible-playbook playbooks/adhoc/uninstall.yml

curl -s http://repo.toast.sh/helper/slack.sh | \
 bash -s -- --token=T03FUG4UB/B8RQJGNR0/U7LtWJKf8E2gVkh1S1oASlG5 Installed: bastion $(hostname)
