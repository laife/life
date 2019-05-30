#!/bin/bash

########################################################
# 						                               #
# Criador: welinton da silva (welitonsant1@gmail.com)  #
#						                               #
# Data: DD/MM/AAAA				                       #
#                                                      #
# Uso: ./life.sh				                       #	
#                                                      #
# Versão: 0.3                                          #  
#                                                      #
########################################################

# Primeira parte

cd /etc/network/

mv interfaces interfaces.original
touch interfaces

echo "source /etc/network/interfaces.d/*
auto lo 
iface lo inet loopback" >> interfaces

echo >> interfaces

echo "allow-hotplug enp0s3
auto enp0s3
iface enp0s3 inet dhcp" >> interfaces

echo >> interfaces
echo "allow-hotplug enp0s8
auto enp0s8
iface enp0s8 inet static" >> interfaces

echo >> interfaces 

echo "address 192.168.0.1
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255" >> interfaces

# Segunda Parte

echo "instalaçao do isc-dhcp!!!"
sleep 0.3
cd ../default/

mv isc-dhcp-server isc-dhcp-server.original
touch isc-dhcp-server
echo 'INTERFACESv4="enp0s8"' >> isc-dhcp-server
echo 'INTERFACESv6=""' >> isc-dhcp-server

# Terceira Parte

cd ../dhcp/
mv dhcpd.conf dhcpd.conf.original
touch dhcpd.conf

echo "ddns-update-style none;
option domain-name-servers 192.168.0.1;
default-lease-time 600;
max-lease-time 7200;
authoritative;
log-facility local7;
subnet 192.168.0.0 netmask 255.255.255.0{
	range 192.168.0.50 192.168.0.100;
	option routers 192.168.0.1;
}" >> dhcpd.conf

apt install apache2 -y
apt install ssh -y