# !/bin/sh

apt-get install git-all curl net-tools

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo usermod -aG docker $USER
sudo system ctl restart docker
sudo chmod 666 /var/run/docker.sock
