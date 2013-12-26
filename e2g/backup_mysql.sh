#!/bin/bash

MYSQL_HOST='localhost'
MYSQL_PASS='xxxxxxxx'
MYSQL_USER='root'
BACKUP_DIR='/var/backup/mysql'
TODAY=$(date +%Y.%m.%d)
OLD_BACKUP=$(date --date '15 days ago' +%Y.%m.%d)

mkdir -p $BACKUP_DIR/$TODAY


mysqlcheck -u "$MYSQL_USER" -p"$MYSQL_PASS" -A -r -o -s -a --use-frm

for DATABASE in $(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASS" --skip-column-names -e "show databases"); do
        for TABLE in $(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASS" --skip-column-names $DATABASE -e "show tables"); do
                mysqldump -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS --default-character=latin1 $DATABASE $TABLE > $BACKUP_DIR/$TODAY/$DATABASE-$TABLE.$TODAY.sql
                /bin/bzip2 $BACKUP_DIR/$TODAY/$DATABASE-$TABLE.$TODAY.sql
        done
done

if [ -d $BACKUP_DIR/$OLD_BACKUP ]; then
        rm -r $BACKUP_DIR/$OLD_BACKUP
fi
