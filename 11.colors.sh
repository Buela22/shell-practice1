#!/bin/bash

R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[0m'


USERID=$(id -u)
if [ $USERID -ne 0 ];then
    echo "Error : please run this script with root privelage"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
    echo -e "Installing $2 ...$R is failure $N"
    exit 1
else
    echo -e "Installing $ 2...$G is success $N"
fi
}

dnf list installed mysql
if [ $? -ne o ];then
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "mysql already exist ...$G Skipping $N"
fi    

dnf install nginx -y
if [ $? -ne o ];then
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e "nginx already exist ...$G Skipping $N"
fi    



dnf install python -y
if [ $? -ne o ];then
    dnf install python -y
    VALIDATE $? "python"
else
    echo -e "python already exist ...$G Skipping $N"
fi  
