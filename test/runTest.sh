#!/bin/sh

TEST=$1
CTEST=${TEST}_c
HSTEST=${TEST}_hs
shift

TMPFILE_C=`mktemp`
TMPFILE_HS=`mktemp`
./$CTEST $* | grep -v "'linker' input unused" > $TMPFILE_C
./$HSTEST $* > $TMPFILE_HS
if [ -n "`diff $TMPFILE_C $TMPFILE_HS`" ]
then
  echo $TEST failed!
  echo $TMPFILE_C $TMPFILE_HS
  diff $TMPFILE_C $TMPFILE_HS
  # exit 1
else
  echo $TEST succesfull!
  rm $TMPFILE_HS $TMPFILE_C
fi
