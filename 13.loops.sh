#!/bin/bash

R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[0m'


LOGS_FOLDER="/var/log/shell-practice"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/12-logs.log
mkdir -p $LOGS_FOLDER
echo "Script started executing at : $(date)" | tee -a $LOGS_FILE

USERID=$(id -u)
if [ $USERID -ne 0 ];then
    echo "Error : please run this script with root privelage"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
    echo -e "Installing $2 ...$R is failure $N" | tee -a $LOGS_FILE
    exit 1
else
    echo -e "Installing $2...$G is success $N" | tee -a $LOGS_FILE
fi
}


for package in $@
do
    echo "Package is : $package"
done    