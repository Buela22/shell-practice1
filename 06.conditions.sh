#!/bin/bash

NUMBER=$1

if [ $NUMBER -lt 10 ]; then
    echo "False the $NUMBER is less than 6 "
elif [ $NUMBER -eq 10 ]; then
    echo "The $NUMBER is equal "    
else
     echo "True the $NUMBER is greater than 6"
fi     



