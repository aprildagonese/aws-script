#!/bin/bash
echo -e "AWS Script Project"
echo ""

#AWS variables
vpc_id="vpc-0f682c27752d49735"
subnet_id="subnet-0a71f7b4a74cd4461"
route_table="rtb-0aaa0300e54d7167d"
internet_gateway="igw-0b860335a9969ee3e"
security_group_id="sg-017520df651c90bea"
aws_image_id="ami-0ec49d80d3f7f4bb0"
instance_type="t2.micro"
tag="Adagonese1"
aws_key_pair="MyKeyPair"
ssh_key="MyKeyPair.pem"
uid=$RANDOM

# Generate AWS Keys & set permissions
if [ ! -f MyKeyPair.pem ]; then
  echo -e "Generating key Pairs"
  aws2 ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
  echo "Setting permissions"
  chmod 600 $ssh_key
  aws2 ec2 describe-key-pairs --key-name MyKeyPair
fi

# Create the instance
instance_data=$(aws2 ec2 run-instances --image-id $aws_image_id --count 1 --instance-type $instance_type --key-name $aws_key_pair --security-group-ids $security_group_id --subnet-id $subnet_id --associate-public-ip-address --user-data file://install_rails --tag-specifications "ResourceType=instance,Tags=[{Key=webserver,Value=$tag}]")

echo "Booting up your instance... hang tight!"
sleep 15
echo ""

elastic_ip=$(aws2 ec2 describe-instances --filter "Name=tag:webserver,Values=$tag" --query 'Reservations[0].Instances[0].PublicIpAddress' | cut -d'"' -f2)

echo "Now, give us about 10 minutes to finish loading Rails, and then visit $elastic_ip:3000 in your browser!"
echo ""
echo "Want to get your hands dirty in the meantime? Copy/paste the below to SSH into your machine:"
echo "ssh -i $ssh_key ec2-user@$elastic_ip"
