#!/bin/bash

wp_db_server_name_tar=mysql-32tpvj.mysql.database.azure.com
wp_db_user_tar=dbadmin@mysql-32tpvj
wp_db_password_tar=iTalent@27
wp_db_name_tar=wordpress
user_name=azureadmin

# Above values should be input to the script but for testing we are passing the variables as hardcoded values

#read -p "Enter your db name : " database
database=${1}

dbname=$(mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "show databases;"| grep $database)

echo db fetched from server: $dbname
echo db name entered by user: $database


if [ $database = "$dbname" ]; then
  echo database is already exist.. now it will take the existing db backup and imports to target
  mysqldump -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $wp_db_name_tar > /home/$user_name/storage/db_target_target.sql
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $dbname < /home/$user_name/storage/database.sql
else
  echo database does not exist.. now it will create a new db and imports to target
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "CREATE DATABASE $database CHARACTER SET utf8;"
  mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar $database < /home/$user_name/storage/database.sql
fi

# Below lines will change the redirection of the URL form source to target
mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "use $database;SET SQL_SAFE_UPDATES=0;UPDATE wp_options SET option_value = replace(option_value, 'http://lb-w3xwky.eastus.cloudapp.azure.com', 'https://lb-32tpvj.eastus.cloudapp.azure.com') WHERE option_name = 'home' OR option_name = 'siteurl';UPDATE wp_posts SET guid = replace(guid, 'http://lb-w3xwky.eastus.cloudapp.azure.com','https:/lb-32tpvj.eastus.cloudapp.azure.com');UPDATE wp_posts SET post_content = replace(post_content, 'http://lb-w3xwky.eastus.cloudapp.azure.com', 'https://lb-32tpvj.eastus.cloudapp.azure.com');"
# mysql -h $wp_db_server_name_tar -u $wp_db_user_tar -p$wp_db_password_tar -e "UPDATE wp_options SET option_value = replace(option_value, 'http://lb-3lvmnp.eastus.cloudapp.azure.com', 'https://lb-u4nerw.eastus.cloudapp.azure.com') WHERE option_name = 'home' OR option_name = 'siteurl';UPDATE wp_posts SET guid = replace(guid, 'http://lb-3lvmnp.eastus.cloudapp.azure.com','https://lb-u4nerw.eastus.cloudapp.azure.com');UPDATE wp_posts SET post_content = replace(post_content, 'http://lb-3lvmnp.eastus.cloudapp.azure.com', 'https://lb-u4nerw.eastus.cloudapp.azure.com');"
