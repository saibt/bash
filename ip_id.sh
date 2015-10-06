#!/bin/bash

export TARGET="$1"

# Testing if parameters are passed
if [ -z ${TARGET} ]; then
    echo "you should spend at least one target..... exiting."
else
   wget ${TARGET} 
fi




