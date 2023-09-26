# XenMinerTools
Set of tools to update and run Xen Miner

These scripts make the below assumptions:

1. That you have tmux installed
2. That XenMiner is installed in /opt/xenminer/


Install by:

cd /opt/

sudo git clone https://github.com/LokiNugget/XenMinerTools

sudo chmod -R +x XenMinerTools/*

Note: Make sure you place your own address in update_xenblocks.sh under new_account_value - this will ensure your address is pushed into the config after pulling fresh code.
sudo vim /opt/XenMinerTools/update_xenblocks.sh 


Script details:
update_xenblocks.sh will pull in a fresh copy of the latest code from teh official XenBlock repo and ensure your address is placed in the config.conf file

start_xenblocks.sh will check how many cores your CPU has and start that many instances of the miner, on 1 screen using TMUX.
Note: you can pass in a parameter (example below) if you want to run a certian amaount of sessions.

./start_xenblocks 4
