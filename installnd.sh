#!/bin/sh
if [ "$1" == "db" ]; then
    echo "Removing local.xml and dropping db"
    rm -rf htdocs/app/etc/local.xml
else
    echo "Removing magento files and dropping db"
    rm -rf htdocs
    git checkout -- htdocs
fi

mysql -u root -proot -Bse "drop database if exists mageskel;"