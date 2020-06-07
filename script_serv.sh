:q#!/bin/bash
echo "Установка nfs-utils"
yum install nfs-utils
echo "Sleeping for 5 seconds…"
sleep 5
echo "Готово!!!!Урааа!!!"
echo "==========================================================================="

echo "Включение службп rpc nfs"
systemctl enable rpcbind nfs-server
sleep 5
echo "Готово!!!!Урааа!!!"
echo "==========================================================================="

echo "Выполняется запуск служб rpcbind nfs-server"
systemctl start rpcbind nfs-server
sleep 5
echo "Готово!!!!Урааа!!!"

echo "==========================================================================="
echo "Создание папки для NFS"
mkdir /nfs_share
chmod -R 777 /nfs_share
echo "==========================================================================="

echo "Настройка файла exports"
echo "/nfs_share  192.168.11.0/24(rw,sync,no_wdelay,nohide,root_squash,no_all_squash)" > /etc/exports
echo "Готово!!!!Урааа!!!"
echo "==========================================================================="

echo "Перезапуск службы nfs, чтобы служба перечитала конфигурацию"
exportfs -r
echo "==========================================================================="

echo "Работа с firewalld"
systemctl enable firewalld.service
systemctl start firewalld.service
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
echo "Готово!!!!Урааа!!!"
echo "==========================================================================="

#####
1) 111/udp 20048/udp 47357/udp 38743/udp 2049/udp
firewall-cmd --zone=public --add-port=20048/udp --permanent
2) Добавить в файл конфигурации /etc/sysconfig/nfs
3) Понять как запусть vagrant provosion на отдельной машине 

