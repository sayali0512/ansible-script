#!/bin/bash


downloadwordpressimporter(){
  wget -p https://wordpress.org/plugins/search/wordpress-importer.0.7.zip/ /home/azureadmin/
}

extractfile(){
  sudo apt install unzip
  sudo unzip /home/azureadmin/downloads.wordpress.org/plugin/wordpress-importer.0.7.zip
  sudo cp -rf /home/azureadmin/wordpress-importer /var/www/html/wordpress/wp-content/plugins/
  sudo rm -rf home/azureadmin/wordpress-importer
}
downloadwordpressimporter 
extractfile 
