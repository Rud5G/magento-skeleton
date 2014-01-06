#!/bin/bash

#if Magento installed then exit
#if --force flag then
#rm -rf htdocs && git checkout -- htdocs

#Install Magento using n98-magerun.

if [ -f ~/.n98-magerun.yaml ]; then
    rm ~/.n98-magerun.yaml
fi

cp .n98-magerun.yaml ~/.n98-magerun.yaml

#Install composer dependencies - including dev
./composer.phar update

./n98-magerun.phar install --noDownload --installationFolder=htdocs --useDefaultConfigParams=yes --replaceHtaccessFile=yes


#bit of a hack to delete git history - we don't want the clone, we only want the files
#cd htdocs
#rm -rf .git
