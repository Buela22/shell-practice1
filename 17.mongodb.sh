#!/bin/bash
USERID=$(id -u)
R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[0m'


LOGS_FOLDER="/var/log/shell-practice"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/12-logs.log


mkdir -p $LOGS_FOLDER
echo "Script started executed at : $(date)" | tee -a $LOGS_FILE


if [ $USERID -ne 0 ];then
    echo "Error : please run this script with root privelage"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
    echo -e " $2 ...$R is failure $N" | tee -a $LOGS_FILE
    exit 1
else
    echo -e " $2...$G is success $N" | tee -a $LOGS_FILE
fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>>$LOGS_FILE
VALIDATE $? "Installing mongodb"

systemctl enable mongod &>>$LOGS_FILE
VALIDATE $? "Enabling mongodb"

systemctl start mongod 
VALIDATE $? "Satrting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to mongodb"

systemctl restart mongod
VALIDATE $? "Restarting mongodb"