#!/usr/bin/env bash

set -x

# Elevate priviledges, retaining the environment.
sudo -E su

curl -sOL https://repo.toast.sh/helper/slack.sh | \
 bash -s -- --token=TATRUQ6P2/BAY9WSD7C/1bCckidSMB8KctWf2CgbHGtN Install: \`bastion\` $(hostname)

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
ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/openshift-provisioners/config.yml


# If needed, uninstall with the below:
# ansible-playbook playbooks/adhoc/uninstall.yml

curl -sOL https://repo.toast.sh/helper/slack.sh | \
 bash -s -- --token=TATRUQ6P2/BAY9WSD7C/1bCckidSMB8KctWf2CgbHGtN --color=good Installed: \`bastion\` $(hostname)