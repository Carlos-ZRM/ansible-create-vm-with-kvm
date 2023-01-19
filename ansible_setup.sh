#!/usr/bin/bash


ROOT_DIR="./ansible"
ANSIBLE_DIRS="env,handlers,meta,tasks,templates,files,vars"
ANSIBLE_ENVS="local"
ANSIBLE_GROUPS="kvm_hosts_local"
TASKS="install_packages,cloud_images,cloud_init,create_vm"

#rm -r $ROOT_DIR
mkdir $ROOT_DIR

# Create main structure
bash -c "mkdir -p  ${ROOT_DIR}/{${ANSIBLE_DIRS}}"
bash -c "touch ${ROOT_DIR}/{${ANSIBLE_DIRS}}/main.yml"

# create env directories
bash -c "mkdir -p ${ROOT_DIR}/env/{${ANSIBLE_ENVS}}/group_vars/{${ANSIBLE_GROUPS}}"
bash -c "touch ${ROOT_DIR}/env/{${ANSIBLE_ENVS}}/hostname.yml"
bash -c "touch ${ROOT_DIR}/env/{${ANSIBLE_ENVS}}/group_vars/{${ANSIBLE_GROUPS}}/{vars.yml,vault.yml}"

# create tasks

bash -c "touch ${ROOT_DIR}/tasks/{${TASKS}}.yml"
cp ansible.cfg $ROOT_DIR/

openssl rand -base64 24 > ${ROOT_DIR}/.pass_file

tree

cd $ROOT_DIR
pwd

find ./ -name vault.yml | xargs ansible-vault encrypt --encrypt-vault-id=setup 

cd -

pwd
