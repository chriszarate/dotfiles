#!/bin/sh

sudo apt-get -y install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

## Docker
if ! grep -q "^deb .*docker" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) nightly" # no stable for disco yet
fi

## Pop! OS
if ! grep -q "^deb .*system76/pop" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
	sudo add-apt-repository -y ppa:system76/pop
fi

## Update
sudo apt-get update
