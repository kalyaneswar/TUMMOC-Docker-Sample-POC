#!/bin/bash

touch /tmp/disk-resize.log 
lsblk >> /tmp/disk-resize.log 
# sudo growpart /dev/nvme0n1 4 >> /tmp/disk-resize.log #for t3.micro
sudo growpart /dev/xvda 4 >> /tmp/disk-resize.log  # for t2.micro
sudo lvextend -l +50%FREE /dev/RootVG/rootVol >> /tmp/disk-resize.log 
sudo lvextend -l +50%FREE /dev/RootVG/varVol >> /tmp/disk-resize.log 
sudo xfs_growfs / >> /tmp/disk-resize.log 
sudo xfs_growfs /var >> /tmp/disk-resize.log 