#!/bin/bash
echo "
##############################################################################
## Redis backup
## Date: `date`
##############################################################################
"

BUCKET=svven-backups
EXPORTFILE=dump_`date +%u`.rdb # day of week
COMPRESSEDFILE=$EXPORTFILE.tgz

sudo cp /var/lib/redis/dump.rdb $EXPORTFILE
sudo chown svven $EXPORTFILE
tar -czf $COMPRESSEDFILE $EXPORTFILE

s3cmd put ./$COMPRESSEDFILE s3://$BUCKET
rm $COMPRESSEDFILE $EXPORTFILE
