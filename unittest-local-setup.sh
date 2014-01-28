#!/bin/sh
#
# Setup this install for Unit Tests
# Installs dev dependencies, creates a database,
# deploys the dev modules to the magento root, and
# configures EcomDev PHPUnit
#
# Author: Aydin Hassan <aydin@wearejh.com>
#

usage()
{

    echo '
    usage: $0

    This script installs or uninstalls Magento

    OPTIONS:
     -?, --help        Show this message
     --dbUser          The database user
     --dbPass          The database password
     --dbHost          The database host
     --dbName          The database name (Unit Test database, seperate from Magento DB)
     --baseUrl         The Store Base URL

    '
    exit 1
}

while [[ $# > 0 ]]
do
    key="$1"
    shift

    case $key in
        --dbUser)
            dbUser="$1"
            shift
            ;;
        --dbPass)
            dbPass="$1"
            shift
            ;;
        --dbHost)
            dbHost="$1"
            shift
            ;;
        --dbName)
            dbName="$1"
            shift
            ;;
         --baseUrl)
            baseUrl="$1"
            shift
            ;;
        *)
            # unknown option
        ;;
    esac
done

if [ -z "$dbUser" ] || [ -z "$dbPass" ] || [ -z "$dbHost" ] || [ -z "$dbName" ] || [ -z "$baseUrl" ]; then
    usage
fi

if [ ! -f "htdocs/app/local.xml" ]; then
    echo "
    Please setup Magento before installing Unit Tests
    "
    exit 1
fi

#create unit test database
mysql -u $dbUser -p$dbPass -h $dbHost -Bse "CREATE DATABASE $dbName;"

if [ $? == "1" ]; then
    echo "
    Failed to create database '$dbName', check the given credentials are correct and the database name is valid
    "
    exit 1
fi

#Install all composer dependencies including dev
./composer.phar install --prefer-dist

#Deploy dev Magento modules, EcomDev_PHPUnit
php vendor/bin/composerCommandIntegrator.php magento-module-deploy

cd htdocs/shell
#Setup the unit test config
php ecomdev-phpunit.php -a install
php ecomdev-phpunit.php -a magento-config --db-host $dbHost --db-name $dbName --db-user $dbUser --db-pass $dbPass --base-url $baseUrl

#Can't use the below check as ecomdev-phpunit.php doesn't return an error status on failing to install
#if [ $? == "1" ]; then
#    echo "Failed to configure EcomDev_PHPUnit"
#fi

echo "\nDone!"
echo "Run the Unit Tests in the 'htdocs' directory by typing 'phpunit'"

