#!/bin/bash
echo "
##############################################################################
## Redis restore
## Date: `date`
##############################################################################
"

BUCKET=svven-backups
IMPORTFILE=dump_`date +%u`.rdb # day of week
COMPRESSEDFILE=$IMPORTFILE.tgz

s3cmd get s3://$BUCKET/$COMPRESSEDFILE $COMPRESSEDFILE
tar -xzf $COMPRESSEDFILE $IMPORTFILE

rm $COMPRESSEDFILE
sudo mv $EXPORTFILE /var/lib/redis/dump.rdb
sudo chown redis:redis /var/lib/redis/dump.rdb
sudo service redis-server restart
