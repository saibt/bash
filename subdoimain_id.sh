#!/bin/bash
# This script scans a particular domain in search of its subdomains.
# By Daniel Saibt
# Date: 10/12/2014
test_connectivity() {

export TARGET="$1"

# Testing if parameters are passed
if [ -z ${TARGET} ]; then
    echo "you should spend at least one target..... exiting."
    exit 0
else
   CONNECTIVITY=$(curl -Is ${TARGET} | head -n1 | awk {' print $2 '})
   echo "Testing connection with the domain...."
   case ${CONNECTIVITY} in
   	200) echo "The domain answered with return code: ${CONNECTIVITY}" ; return 0 ;;
    301) echo "The domain answered with return code: ${CONNECTIVITY}" ; return 3 ;;
    400) echo "The request could not be understood by the server due to malformed syntax... exiting." ; exit ;;
    404) echo "Domain is not acessible... exiting." ; exit ;;
      6) echo "Could not resolve host.... exiting." ; exit ;;
      *) echo "Not possible identify return code.... Make sure the domain is active.... exiting." ; exit ;;
   esac   
fi
}

test_connectivity $1

if [ $? -eq 0 -o $? -eq 3 ]; then
	echo "The following were found subdomains"
	curl -sL $1 | grep -i href="" | cut -d"/" -f3 | grep "\." | cut -d"\"" -f1 | uniq | egrep -v "png|jpg|<|>"
fi










