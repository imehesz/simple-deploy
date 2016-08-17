#!/bin/bash

echo "Production User [enter]:";
read PRODUSER;

if [ -n "$PRODUSER" ]; then
  PRODUSER="produser";
fi

echo "Production Server [enter]:";
read PRODSERVER;

if [ -n "$PRODUSER" ]; then
  PRODSERVER="google.com";
fi

echo "Production SSH Port [enter]:";
read PRODPORT;

if [ -n "$PRODPORT" ]; then
  PRODPORT="22";
fi

echo "Production Destination [enter]:";
read PRODDESTINATION;

ERRORSTRING="Error. Please make sure you've indicated correct parameters";

if [ $# -eq 0 ]
    then
        echo $ERRORSTRING;
elif [ $1 == "live" ]
    then
        if [[ -z $2 ]]
            then
                echo "Running dry-run"
                rsync --dry-run -az --force --delete --progress --exclude-from=rsync_exclude.txt -e "ssh -p$PRODPORT" ./ $PRODUSER@$PRODSERVER:$PRODDESTINATION
        elif [ $2 == "go" ]
            then
                echo "Running actual deploy"
                rsync -az --force --delete --progress --exclude-from=rsync_exclude.txt -e "ssh -p$PRODPORT" ./ $PRODUSER@PRODSERVER:$PRODDESTINATION
        else
            echo $ERRORSTRING;
        fi
fi
