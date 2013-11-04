#!/bin/bash

#Install Magento using n98-magerun.

if [ -f ~/.n98-magerun.yaml ]; then
    rm ~/.n98-magerun.yaml
fi

cp .n98-magerun.yaml ~/.n98-magerun.yaml

php n98-magerun.phar install --installationFolder=htdocs --installSampleData=no --useDefaultConfigParams=yes --replaceHtaccessFile=yes
