#!/bin/bash
echo -e "AWS Script Project"
echo ""
echo ""

#AWS variables
vpc_id="vpc-0f682c27752d49735"
sub_id="subnet-0a71f7b4a74cd4461"
route_table="rtb-0aaa0300e54d7167d"
internet_gateway="igw-0b860335a9969ee3e"
sec_id="sg-017520df651c90bea"
aws_image_id="ami-0ec49d80d3f7f4bb0"
i_type="t2.micro"
tag="Adagonese"
aws_key_name="MyKeyPair"
ssh_key="MyKeyPair.pem"
uid=$RANDOM

# Generate AWS Keys, store locally, and set R/O permissions
if [ ! -f MyKeyPair.pem ]; then
  echo -e "Generating key Pairs"
  aws2 ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
  echo "Setting permissions"
  chmod 600 $ssh_key
  aws2 ec2 describe-key-pairs --key-name MyKeyPair
fi

echo "Creating EC2 instance in AWS"
instance_data=$(aws2 ec2 run-instances --image-id ami-0ec49d80d3f7f4bb0 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-017520df651c90bea --subnet-id subnet-0a71f7b4a74cd4461 --associate-public-ip-address --user-data file://install_rails --tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=rails17}]')

#echo "Unique ID: $uid"
elastic_ip=$(aws2 ec2 describe-instances --filter 'Name=tag:webserver,Values=rails17' --query 'Reservations[0].Instances[0].PublicIpAddress' | cut -d'"' -f2)
echo "Elastic IP: $elastic_ip"

echo "Booting up your instance... hang tight!"
sleep 30
echo ""

echo "Now, give us about 10 minutes to load, and then visit $elastic_ip:3000 in your browser!"
echo ""
echo "Want to get your hands dirty? Copy/paste the below to SSH into your machine:"
echo "ssh -i $ssh_key ec2-user@$elastic_ip"
