
#!/bin/bash

# It will dynamically replace source DB and URL with target

config_path=/home/azureadmin/storage/site/${5}/wp-config.php

update_target_info() {
  sudo sed -i "s~mysql-3lvmnp.mysql.database.azure.com~${1}~" ${config_path}
  sudo sed -i "s~dbadmin@mysql-3lvmnp~${2}~" ${config_path}
  sudo sed -i "s~'DB_PASSWORD', 'iTalent@27'~'DB_PASSWORD', '${3}'~" ${config_path}
  sudo sed -i "s~define('DB_NAME', 'wordpress');~define('DB_NAME', '${4}';~" ${config_path}
}

update_target_info ${1} ${2} ${3} ${4} 
