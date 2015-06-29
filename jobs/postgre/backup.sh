#!/bin/bash
echo "
##############################################################################
## Postgre backup
## Date: `date`
##############################################################################
"

BUCKET=svven-backups
EXPORTFILE=dump_`date +%u`.pdb # day of week
COMPRESSEDFILE=$EXPORTFILE.tgz

pg_dump -f ./$EXPORTFILE -h $DATABASE_HOST -c svven
tar -czf $COMPRESSEDFILE $EXPORTFILE

s3cmd put ./$COMPRESSEDFILE s3://$BUCKET
rm $COMPRESSEDFILE $EXPORTFILE
