install git, nodejs and npm to your server first

# INSTALlING GIT
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install git

# INSTALLING NODEJS AND NPM
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs

Then create you deployment.sh and startup-script.sh files

Make sure you chmod +x deployment.sh first so it can run

Then run ./deployment.sh
