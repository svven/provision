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

cp /var/lib/redis/dump.rdb $EXPORTFILE
tar -czf $COMPRESSEDFILE $EXPORTFILE

s3cmd put ./$COMPRESSEDFILE s3://$BUCKET
rm $COMPRESSEDFILE $EXPORTFILE
