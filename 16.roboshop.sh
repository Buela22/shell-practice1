#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-06d12382f5f429829"

for instance in $@
do
   INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID  --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)
   #Get private Ip
   if [ $instance != "frontend" ];then
        IP=$(aws ec2 describe-instances --instances-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instances-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    fi

    echo "$instnace: $IP"
   
done

