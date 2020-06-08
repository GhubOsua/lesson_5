#!/bin/bash
echo "Установка nfs-utils"
yum install nfs-utils
echo "Sleeping for 5 seconds…"
sleep 5
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Включаем автозагрузку для служб rpc nfs"
systemctl enable rpcbind nfs-server
sleep 5
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Работа с firewalld"
systemctl enable firewalld.service
systemctl start firewalld.service
firewall-cmd --zone=public --add-port=111/udp --permanent
firewall-cmd --zone=public --add-port=20048/udp --permanent
firewall-cmd --zone=public --add-port=47357/udp --permanent
firewall-cmd --zone=public --add-port=38743/udp --permanent
firewall-cmd --zone=public --add-port=2049/udp --permanent
firewall-cmd --reload

#firewall-cmd --permanent --zone=public --add-service=nfs
#firewall-cmd --permanent --zone=public --add-service=mountd
#firewall-cmd --permanent --zone=public --add-service=rpc-bind
#firewall-cmd --reload
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Создание папки для NFS"
mkdir /nfs_share
chmod -R 777 /nfs_share
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Настройка файла exports"
echo "/nfs_share  192.168.11.0/24(rw,sync,no_wdelay,nohide,root_squash,no_all_squash)" > /etc/exports
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Перезапуск службы nfs, чтобы служба перечитала конфигурацию"
exportfs -r
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Устанавливаем конкретные порты NFS для firewall"
echo -e 'RPCNFSDARGS="--port 2049" \nMOUNTD_PORT=20048 \nLOCKD_TCPPORT=47357 \nLOCKD_UDPPORT=47357 \nSTATD_PORT=38743' >> /etc/sysconfig/nfs
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="

echo "Выполняется запуск служб rpcbind nfs-server"
systemctl start rpcbind nfs-server
sleep 5
echo -e "Готово!!!!Урааа!!!\n\n\n"
echo "==========================================================================="
