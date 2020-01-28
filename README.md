# AWS Script

This project is a bash script that spins up an EC2 instance loaded with the default Amazon Linux 2 AMI and running Ruby on Rails. It takes about 10 minutes to execute. Once finished, the script will print the IP address that a user can visit in their browser to view the default Rails web page.

## Prerequisites

  1. Version 2 of the AWS CLI is required to run this script, and it must be configured with an IAM user that has permissions to launch an EC2 instance in your account.
      - CLI installation instructions are available [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux-mac.html#cliv2-linux-mac-remove).
      - Instructions for configuring the AWS CLI with your user are available [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).
  2. The script also assumes that you have an existing VPC with a public subnet, a route pointing to an Internet Gateway, and a default Security Group and NACL allowing all incoming/outgoing traffic from the public internet.

## Instructions

  1. Clone the repo to your local environment:
    `git clone https://github.com/aprildagonese/aws-script`
  2. `cd aws-script`
  3. To run the script: `./aws-script`

## Default Config

The script is set up to load your instance in the below location and with the below config. You can change any of these variables in the `create_ec2.sh` file:

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

After booting your instance, the script is set to load Rails version 5.2.4 and Ruby version 2.6.3. These versions can be updated in `install_rails`, but version changes may require additional configuration changes not covered here.

## Troubleshooting

To follow along with the Rails install once the instance has booted up:
  1. Copy the SSH instructions that the script will output for you. It will look like this: `ssh -i MyKeyPair.pem ec2-user@[YOUR SPECIFIC ELASTIC IP]`
  2. When asked for confirmation that you want to connect, answer `yes`
  3. Once connected, run `tail -f /tmp/part-001.log` to watch the output of the Rails install

## Project Instructions

#### Assignment

* Using any language you prefer, write code that brings up an EC2 instance running the default page of a web application after running a single command.
* The command can (and likely will) call a longer shell script, or other configuration management code.
* The web application can be any common framework (Django, Rails, Symfony, etc.), but not the default Nginx or Apache setup.
* Your credentials are attached (including the assigned region). The credentials do not have access to EKS, ECS, S3, ELB, ASG:WQ, or Route53.
* If needed, you can manually create pre-requisites such as ssh key pairs and the like.
* _Before the script is run, there should be no compute instances running and afterward the script should output the address of your working web application._

#### Evaluation Criteria

* Please don't take more than 3 hours total over the next few days.
* Timekeeping is up to you and we expect your finished response in a reasonable amount of time.
* You are being evaluated based on the quality of your code and configuration, on the clarity of your communication, and on project presentation.
* Source control is expected as well as documentation that should explain how you approached the challenge, what assumptions you've made, and reasoning behind the choices in your approach.

## Project Approach & Assumptions

When deciding my general approach to the project, I tried to be very conscious of the 3-hour time limit given in the instructions. While I've used templating tools with AWS in the past, I've never had to start them from scratch, and I was nervous about losing too much time just on setup. I knew I could spin up resources quickly using either the console or the CLI, so I created my network environment by hand in the console and decided to write the script itself using bash and the AWS CLI. Even though it's still technically in beta, I went with version 2 of the CLI because it's so much faster and easier to install than version 1, and it had worked well for me in the past. In terms of frameworks, I have the most experience setting up Rails, so that seemed like an easy choice at the time.

Early on, my plan looked like this:

  - Hour 1: Network setup, generating the instances themselves, and researching options for the Rails install
  - Hour 2: Getting Rails up and running consistently
  - Hour 3: Documentation

I was right about hours 1 and 3 of this plan.

I noticed that my IAM user didn't have access to subscriptions in the AWS Marketplace to use a Rails AMI, so it looked like I would be hand rolling my Rails install. I don't think I've ever had as much trouble setting up Rails in any environment as I had here. Among the issues I hit:

 - Getting visibility into what was going wrong each time I made a change to my install script
 - Aligning versions of Ruby, Rails, and Node with the requirements of my Linux AMI, and then with each other
 - Knowing where exactly the install was happening on the machine, and by which user
 - The slow turnaround time to test changes I made to the script by spinning up a new instance each time

 Full disclosure: getting through the install took a lot longer than the 1 hour I had allocated for it. For the sake of keeping to the time limit, I would have been willing to turn in a partially-finished project with complete documentation of what I had tried and what my next steps would be. But AWS was fun and irritating, and I wanted to figure out the solution for myself, so I kept going until it was done.

## What I Would Do Next/Differently

  - Research faster approaches for testing changes without running through the full load process every time
  - Spend a few minutes doing high-level research on alternative frameworks that install easily onto EC2 with little configuration
  - Automated testing. Is that a thing for a script like this? I'd look into that, too
  - Not accidentally commit a key pair to Github (sorry! I deleted it.)

Thank you so much for the opportunity to complete this project! I had so much fun doing it!
