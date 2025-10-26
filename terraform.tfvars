# NOTE: Update region and ami_id to match your environment.
# The AMI ID must be an Amazon Linux 2 (or similar) HVM AMI in your chosen region.
region        = "us-east-1"
ami_id        = "ami-07d1f1c6865c6b0e7" #ami-0a3c3a20c09d6f377  Example: Amazon Linux 2 AMI for us-east-1
instance_type = "t2.micro"

# Pre-provisioned resource IDs
vpc_id            = "vpc-05b1116bb4746a8b7"
public_subnet_ids = ["subnet-01f88a33436e002b4", "subnet-0e628d04ef4831fad"]
sg_ssh_id         = "sg-0aa00431a1b680abc"
sg_http_id        = "sg-0b19d29072823e060"
sg_lb_id          = "sg-0bb42038f8fb66aa5"

# Resource names from lab tasks
lb_name        = "cmtr-xv69vdlr-lb"
blue_tg_name   = "cmtr-xv69vdlr-blue-tg"
green_tg_name  = "cmtr-xv69vdlr-green-tg"
blue_lt_name   = "cmtr-xv69vdlr-blue-template"
green_lt_name  = "cmtr-xv69vdlr-green-template"
blue_asg_name  = "cmtr-xv69vdlr-blue-asg"
green_asg_name = "cmtr-xv69vdlr-green-asg"

# ASG capacities (for 2 instances each)
asg_desired_capacity = 2
asg_max_size         = 3
asg_min_size         = 1

# Initial traffic weights
blue_weight  = 100
green_weight = 0

# Common tags
common_tags = {
  Project = "BlueGreen-Lab"
  Owner   = "Terraform"
}
