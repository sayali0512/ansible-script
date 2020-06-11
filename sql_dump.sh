#!/bin/bash

wp_db_server_name_tar=mysql-iyhnpt.mysql.database.azure.com
wp_db_user_tar=dbadmin@mysql-iyhnpt
wp_db_password_tar=iTalent@27
wp_db_name_tar=wordpress
user_name=azureadmin

# Above values should be input to the script but for testing we are passing the variables as hardcoded values

read -p "Enter your db name : " database

dbname=$(mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "show databases;"| grep $database)

echo db fetched from server: $dbname
echo db name entered by user: $database


if [ $database = "$dbname" ]; then
  echo database is already exist.. now it will take the existing db backup and imports to target
  mysqldump -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $wp_db_name_tar > /home/$user_name/db_target_target.sql
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $dbname < /home/$user_name/database.sql
else
  echo database does not exist.. now it will create a new db and imports to target
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "CREATE DATABASE $database CHARACTER SET utf8;"
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $database < /home/$user_name/database.sql
fi
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "show databases;"
