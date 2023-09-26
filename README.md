# XenMinerTools
Set of tools to update and run Xen Miner

These scripts make the below assumptions:

1. That you have tmux installed
2. That XenMiner is installed in /opt/xenminer/


Install by:
sudo git clone https://github.com/LokiNugget/XenMinerTools
sudo chmod -R +x XenMinerTools/*

Note: Make sure you place your own address in update_xenblocks.sh under new_account_value - this will ensure your address is pushed into the config after pulling fresh code.
sudo vim /opt/XenMinerTools/update_xenblocks.sh 
