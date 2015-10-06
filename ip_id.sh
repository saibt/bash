#!/bin/bash

export TARGET="$1"

# Testing if parameters are passed
if [ -z ${TARGET} ]; then
    echo "you should spend at least one target..... exiting."
else
   host ${TARGET} > ${TARGET}.log 2> ${TARGET}.log 
   if [ $? -eq 1 ]; then
      echo "Host ${TARGET} not found... exiting"
      exit 1         
    else
       IPS=$(grep -i address ${TARGET}.log | cut -d " " -f4,5 | grep -v address)
       echo "The IP(s) were identified below:"
       echo ${IPS}
       rm -f ${TARGET}.log
   fi
fi
