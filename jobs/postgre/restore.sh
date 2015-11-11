#!/bin/bash
echo "
##############################################################################
## Postgre restore
## Date: `date`
##############################################################################
"

BUCKET=svven-backups
IMPORTFILE=dump_`date +%u`.pdb # day of week
COMPRESSEDFILE=$IMPORTFILE.tgz

s3cmd get s3://$BUCKET/$COMPRESSEDFILE $COMPRESSEDFILE
tar -xzf $COMPRESSEDFILE $IMPORTFILE

psql -f $IMPORTFILE -d svven
rm $COMPRESSEDFILE $EXPORTFILE
