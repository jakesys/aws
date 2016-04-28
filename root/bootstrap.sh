#!/bin/sh

set -e

# install packages
apk -U upgrade
apk add groff less python py-pip
pip install awscli

# make sure our version matches
[ -f /.version-build ] && source /.version-build || source /.version
AWS_VERSION=`aws --version 2>&1 | cut -d/ -f2 | cut -d' ' -f1`
if [ "$VERSION" != "$AWS_VERSION" ]; then
    echo -e "\nERROR: Please update .version with VERSION=$AWS_VERSION\n" 1>&2
    exit 1
fi

# clean up
apk del py-pip
rm -rf /bootstrap.sh /var/lib/apk/* /var/tmp/* /var
