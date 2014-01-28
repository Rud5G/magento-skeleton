#!/bin/bash

usage()
{

  echo "usage: $0 tall|uninstall options"
  echo '
  usage: $0 install|uninstall options

  This script installs or uninstalls Magento

  OPTIONS:
     -?, --help        Show this message
     -f                Force install/uninstall, Necessary to uninstall. For installing, it is neccessary
                       if a Magento install already exists. It will remove the database,
                       and all non commited files
     --dbUser          The database user (OPTIONAL)
     --dbPass          The database password (OPTIONAL)
     --dbHost          The database host (OPTIONAL)
     --dbName          The database name (OPTIONAL)
     --mageVer         Magento Version to Install (Specified in n98-magerun.yaml) (OPTIONAL)
     --baseUrl         The Store Base URL (OPTIONAL)
     -s                If specified will install sample data (OPTIONAL)

     All OPTIONAL options, if not specified, will be prompted for at runtime.
'
}

uninstallMagento()
{
    if [[ -z $1 ]]; then
        return 0
    fi

    forceInstall=$1

    if [[ "$forceInstall" == "true" ]]; then
        ./n98-magerun.phar uninstall -f

        echo "Removing htdocs directory.."
        rm -rf htdocs

        lastCommit=`git rev-parse HEAD`
        echo "Checking out most recent commit..$lastCommit"
        git checkout -- htdocs
    else
        echo "Are you sure you want to remove the Magento install?, pass in -f to force remove"
        echo "WARNING: This will remove the database and all non commited changes"
        exit 1
    fi
}

#vars
sampleData=no
forceInstall=false

type=$1
shift

if [[ "$1" ==  "-?" || "$1" ==  "--help" ||  "$1" ==  "?" ||  "$1" ==  "help" ]]; then
    usage
    exit 0
fi

if [[ "$type" != "install" && "$type" != "uninstall" ]]; then
    usage
    exit 1
fi

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
        --mageVer)
            mageVer="$1"
            shift
            ;;
         --baseUrl)
            baseUrl="$1"
            shift
            ;;
        -s)
            sampleData=yes
            ;;
        -f)
            forceInstall=true
            ;;
        *)
            # unknown option
        ;;
    esac
done

echo -e "\n"
if [[ "$type" == "uninstall" ]]; then
    #Uninstall
    uninstallMagento $forceInstall

elif [[ "$type" == "install" ]]; then
    #Install

    if [[ -f htdocs/app/etc/local.xml &&  "$forceInstall" == "false" ]]; then
        echo "Magento seems to be installed already, pass in -f to force remove"
        echo "WARNING: This will remove the database and all non commited changes"
        exit 1
    elif [[ -f htdocs/app/etc/local.xml && "$forceInstall" == "true" ]]; then
        uninstallMagento $forceInstall
    else
        echo "No previous Magento installation detected"
        echo "Running clean.."
    fi

    #Copy Mage run config
    if [ -f ~/.n98-magerun.yaml ]; then
        rm ~/.n98-magerun.yaml
    fi
    cp .n98-magerun.yaml ~/.n98-magerun.yaml

    #Install Magento using n98-magerun.
    echo "Installing Magento via n98-magerun.."

    n98cmd="./n98-magerun.phar install --installationFolder=htdocs --useDefaultConfigParams=yes --replaceHtaccessFile=yes"
    n98cmd="$n98cmd ${dbUser:+--dbUser=$dbUser} ${dbPass:+--dbPass=$dbPass} ${dbHost:+--dbHost=$dbHost} ${dbName:+--dbName=$dbName}"
    n98cmd="$n98cmd ${mageVer:+--magentoVersionByName=$mageVer} ${sampleData:+--installSampleData=$sampleData} ${baseUrl:+--baseUrl=$baseUrl}"
    #Run!
    $n98cmd

    if [[ "$?" != 0 ]]; then
        #Cleanup
        rm -rf htdocs
        git checkout -- htdocs
        echo "Something went wrong :("
        echo "Usually the case that composer does not have enough memory - check the PHP CLI INI memory limit"
        exit 1
    fi

    #Install composer dependencies - including dev
    echo "Installing composer dependencies.."
    ./composer.phar install --no-dev

    #bit of a hack to delete git history - we don't want the clone, we only want the files
    rm -rf htdocs/.git
else
    usage
fi

/usr/bin/env php vendor/bin/composerCommandIntegrator.php magento-module-deploy
./n98-magerun.phar cache:clean
./n98-magerun.phar cache:flush
./n98-magerun.phar config:set dev/template/allow_symlink 1
echo -e "Done!\n"
