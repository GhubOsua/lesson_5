#!/bin/bash
echo "Установка nfs-utils"
yum -y install nfs-utils
echo "Sleeping for 5 seconds…"
sleep 5
echo "Готово!!!!Урааа!!!"
echo "==========================================================================="

echo "==========================================================================="
echo "Создание папки для NFS"
mkdir /mnt/share_client
chmod -R 777 /mnt/share_client
echo "==========================================================================="

echo "==========================================================================="
echo "Монтирование ФС"
mount -t nfs -o rw,vers=3,udp,soft,noatime,nodiratime,nodev,noexec,nosuid,timeo=300,rsize=1048576,wsize=1048576  192.168.11.101:/nfs_share /mnt/share_client
echo "192.168.11.101:/nfs_share /mnt/share_client nfs -o rw,vers=3,udp,soft,noatime,nodiratime,nodev,noexec,nosuid,timeo=300,rsize=1048576,wsize=1048576 0 0" >> /etc/fstab
echo "==========================================================================="

df -hT
