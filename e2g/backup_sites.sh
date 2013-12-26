#!/bin/bash
NBRE="15"
DIR_DONNEES="/var/www/sites/"
PATH_BACKUP="/var/backup/sites/"
CREATE=$(date -d now-1days '+%Y.%m.%d')
DELETE=$(date -d now-"$NBRE"days '+%Y.%m.%d')
ARCHIVE=$(date -d now-2days '+%Y.%m.%d')
SITES=`ls /var/www/sites/`

## Suppression rapport 
if [ -f /tmp/rapport_backup.txt ]; then
	        rm /tmp/rapport_backup.txt
fi

## - Rotation des logs
## Suppresion des logs de plus de $NBRE
for i in $SITES ; do 
	if [ -f $PATH_BACKUP/$i/$DELETE.tar.bz2 ]; then
		rm -rf $PATH_BACKUP/$i/$DELETE.tar.bz2
	fi
	mkdir -p $PATH_BACKUP/$i/$CREATE
	rsync -a --delete $DIR_DONNEES/$i $PATH_BACKUP/$i/$CREATE/ &> /tmp/rsync-$i.txt
	if grep error /tmp/rsync-$i.txt > /dev/null
	then
		echo " Erreur Rsync pour le backup $i" >> /tmp/rapport_backup.txt
	fi
	rm /tmp/rsync-$i.txt
done

if [ -f /tmp/rapport_backup.txt ]; then
	        mail -s "Erreur de backup [E2G] $CREATE" staff@e2g.eu < /tmp/rapport_backup.txt
	        rm /tmp/rapport_backup.txt
fi


## - Compression du backup precedent
for i in $SITES; do
	if [ -d $PATH_BACKUP/$i/$ARCHIVE ]; then
		tar -cvf $PATH_BACKUP/$i/$ARCHIVE.tar $PATH_BACKUP/$i/$ARCHIVE/ &> /dev/null
		rm -rf $PATH_BACKUP/$i/$ARCHIVE
		pbzip2 -f $PATH_BACKUP/$i/$ARCHIVE.tar
	fi
done
