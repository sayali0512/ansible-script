#!/bin/bash

source_dns_name=${1}
target_dns_name=${2}
target_db_server_name=${3}
target_db_login_name=${4}
target_db_pass=${5}
target_db_name=${6}


# Above values should be input to the script but for testing we are passing the variables as hardcoded values

database=${7}

dbname=$(mysql -h $target_db_server_name -u $target_db_login_name -p$target_db_pass -e "show databases;"| grep $database)

echo db fetched from server: $dbname
echo db name entered by user: $database


if [ $database = "$dbname" ]; then
  echo database is already exist.. now it will take the existing db backup and imports to target
  mysqldump -h $target_db_server_name -u $target_db_login_name -p$target_db_pass $target_db_name > /home/$user_name/storage/db_target_target.sql
  mysql -h $target_db_server_name -u $target_db_login_name -p$target_db_pass $dbname < /home/$user_name/storage/database.sql
else
  echo database does not exist.. now it will create a new db and imports to target
  mysql -h $target_db_server_name -u $target_db_login_name -p$target_db_pass -e "CREATE DATABASE $database CHARACTER SET utf8;"
  mysql -h $target_db_server_name -u $target_db_login_name -p$target_db_pass $database < /home/$user_name/storage/database.sql
fi

# Below lines will change the redirection of the URL form source to target
mysql -h $target_db_server_name -u $target_db_login_name -p$target_db_pass -e "use $database;SET SQL_SAFE_UPDATES=0;UPDATE wp_options SET option_value = replace(option_value, 'http://$source_dns_name', 'https://$target_dns_name') WHERE option_name = 'home' OR option_name = 'siteurl';UPDATE wp_posts SET guid = replace(guid, 'http://$source_dns_name','https://$target_dns_name');UPDATE wp_posts SET post_content = replace(post_content, 'http://$source_dns_name', 'https://$target_dns_name');"
