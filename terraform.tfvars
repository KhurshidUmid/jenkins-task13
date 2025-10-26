# NOTE: Update region and ami_id to match your environment.
# The AMI ID must be an Amazon Linux 2 (or similar) HVM AMI in your chosen region.
region        = "us-east-1"
ami_id        = "ami-08ae91d91a31119d0" #ami-0a3c3a20c09d6f377  Example: Amazon Linux 2 AMI for us-east-1
instance_type = "t2.micro"

# Pre-provisioned resource IDs
vpc_id            = "cmtr-xv69vdlr-vpc"
public_subnet_ids = ["cmtr-xv69vdlr-public-subnet1", "cmtr-xv69vdlr-public-subnet2"]
sg_ssh_id         = "cmtr-xv69vdlr-sg-ssh"
sg_http_id        = "cmtr-xv69vdlr-sg-http"
sg_lb_id          = "cmtr-xv69vdlr-sg-lb"

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
