#!/bin/bash
# <UDF name="github_runner_token" label="GitHub Runner Token" example="" default="">
# <UDF name="github_repo_url" label="GitHub Runner Token" example="" default="">

## Stackscript Bash Library
source <ssinclude StackScriptID="1">

## Update APT Repositories
system_update

## Install Java
apt install openjdk-17-jdk -y

## Timezone Setting
timedatectl set-timezone $TIMEZONE

## Create Runner User Account
useradd runner
mkdir /home/runner
chown -R runner:runner /home/runner

runuser -l runner -c 'cd /home/runner && mkdir actions-runner && cd actions-runner'
runuser -l runner -c 'cd /home/runner && curl -o actions-runner-linux-x64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-x64-2.314.1.tar.gz'
runuser -l runner -c 'cd /home/runner && echo "6c726a118bbe02cd32e222f890e1e476567bf299353a96886ba75b423c1137b5  actions-runner-linux-x64-2.314.1.tar.gz" | shasum -a 256 -c'
runuser -l runner -c 'cd /home/runner && tar xzf ./actions-runner-linux-x64-2.314.1.tar.gz'

runuser -l runner -c "/home/runner/actions-runner/config.sh --url $GITHUB_REPO_URL --token $GITHUB_RUNNER_TOKEN"
runuser -l runner -c 'nohup /home/runner/actions-runner/run.sh &'

## IP Route Setting
ip route add 10.0.0.0/8 via 10.2.1.2 dev eth1

## Clean StackScript
stackscript_cleanup