#!/bin/bash

DIR_MAIL='/var/lib/mail'
BACKUP_DIR='/var/backup/mail'
TODAY=$(date +%Y.%m.%d)
OLD_BACKUP=$(date --date '15 days ago' +%Y.%m.%d)

if [ -d $BACKUP_DIR/$OLD_BACKUP ]; then
        rm -r $BACKUP_DIR/$OLD_BACKUP
fi

mkdir -p $BACKUP_DIR/$TODAY

for DOMAINE in $(ls /var/lib/mail); do
        rsync -a $DIR_MAIL/$DOMAINE $BACKUP_DIR/$TODAY/
done

