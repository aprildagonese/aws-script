# AWS Script

This project is a bash script that spins up an EC2 instance loaded with default Linux 2 AMI and running Ruby on Rails. It takes about 10 minutes to execute, most of which is installing Rails config after the instance is spun up. Once finished, the script will print the IP address that a user can visit in their browser to view the default Rails web page.

## Instructions

  1. Clone the repo to your local environment:
    `git clone https://github.com/aprildagonese/aws-script`

  2. `cd aws-script`

  3. To run the script: `./aws-script`

## Default Config

The script is set up to load your instance in the following location and with the following config. You can change any of these variables in the `create_ec2.sh` file:

```
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
```



## Troubleshooting

To follow along with the Rails install once the instance has booted up:
  1. Copy the SSH instructions that the script will output for you. It will look like this: `ssh -i MyKeyPair.pem ec2-user@[YOUR SPECIFIC ELASTIC IP]`

  2. When asked for confirmation that you want to connect, answer `yes`

  3. Once connected, run `tail -f /tmp/part-001.log` to watch the output of the Rails install

## Project Assumptions
