#!/bin/bash                                                                                                                                                      
PWD_SITE="var/www/sites"
## Recuperation des informations                                                                                                                                 
echo "Nom du site"
read site
mkdir ${PWD_SITE}/${site}

DIR_HOME="${PWD_SITE}/${site}"

## Ajout user                                                                                                                                                    
useradd $site -d $dir_home -o -g 33 -u 33 -s /bin/false
mkpasswd
echo "Set Password for ${site}"
passwd $user

chown 33:33 -R /var/www/sites/$site
