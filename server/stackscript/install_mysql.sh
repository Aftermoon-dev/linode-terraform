#!/bin/bash
# <UDF name="timezone" label="Server Timezone" example="Asia/Seoul" default="Asia/Seoul">
# <UDF name="root_password" label="DB Root Password" example="p@ssw_o_rdddd" default="p@ssw_o_rdddd">
# <UDF name="root_allowed_ip" label="DB Root Access Allowed IP" example="10.%" default="">

## Stackscript Bash Library
source <ssinclude StackScriptID="1">

## MySQL Server Configuration File
MYSQL_CONF=/etc/mysql/mysql.conf.d/mysqld.cnf

## Update APT Repositories
system_update

## Timezone Setting
timedatectl set-timezone $TIMEZONE

## Install Expect
apt install expect -y

## Install MySQL
apt install mysql-server -y

## MySQL Secure Installation
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Press y|Y for Yes, any other key for No:\"
send \"n\r\"
expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No)\"
send \"y\r\"
expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No)\"
send \"n\r\"
expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No)\"
send \"y\r\"
expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No)\"
send \"y\r\"
expect eof
")
echo $SECURE_MYSQL

## MySQL Timezone Applied
mysql_tzinfo_to_sql /usr/share/zoneinfo > /root/mysql_time_zone.sql
mysql -u root mysql < /root/mysql_time_zone.sql
rm /root/mysql_time_zone.sql

## Set Root Password
mysql -u root -e "CREATE USER 'root'@'$ROOT_ALLOWED_IP' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '$ROOT_PASSWORD'"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'$ROOT_ALLOWED_IP'"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '$ROOT_PASSWORD'"
mysql -u root -p$DBROOT_PASWORD -e "FLUSH PRIVILEGES"

## Stop MySQL
systemctl stop mysql

## Delete Default Value
sed -i -e '/default-time-zone/d' $MYSQL_CONF
sed -i -e '/bind-address/d' $MYSQL_CONF
sed -i -e '/mysqlx-bind-address/d' $MYSQL_CONF

## Set Timezone Setting
echo "default-time-zone = $TIMEZONE" >> $MYSQL_CONF

## Allow from all
echo "bind-address = 0.0.0.0" >> $MYSQL_CONF
echo "mysqlx-bind-address = 0.0.0.0" >> $MYSQL_CONF

## Start MySQL
systemctl start mysql 

## Clean StackScript
stackscript_cleanup