variable "region" {
  description = "The AWS region to deploy the infrastructure in."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances (e.g., Amazon Linux 2)."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t2.micro)."
  type        = string
}

# Pre-provisioned Resource IDs
variable "vpc_id" {
  description = "The ID of the pre-provisioned VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of pre-provisioned public subnet IDs."
  type        = list(string)
}

variable "sg_ssh_id" {
  description = "The ID of the pre-provisioned security group for SSH."
  type        = string
}

variable "sg_http_id" {
  description = "The ID of the pre-provisioned security group for instance HTTP access."
  type        = string
}

variable "sg_lb_id" {
  description = "The ID of the pre-provisioned security group for the ALB."
  type        = string
}

# Resource Names
variable "lb_name" {
  description = "The name for the Application Load Balancer."
  type        = string
}

variable "blue_tg_name" {
  description = "The name for the Blue Target Group."
  type        = string
}

variable "green_tg_name" {
  description = "The name for the Green Target Group."
  type        = string
}

variable "blue_lt_name" {
  description = "The name for the Blue Launch Template."
  type        = string
}

variable "green_lt_name" {
  description = "The name for the Green Launch Template."
  type        = string
}

variable "blue_asg_name" {
  description = "The name for the Blue Auto Scaling Group."
  type        = string
}

variable "green_asg_name" {
  description = "The name for the Green Auto Scaling Group."
  type        = string
}

# ASG Configuration
variable "asg_desired_capacity" {
  description = "The desired number of instances for each ASG."
  type        = number
}

variable "asg_max_size" {
  description = "The maximum number of instances for each ASG."
  type        = number
}

variable "asg_min_size" {
  description = "The minimum number of instances for each ASG."
  type        = number
}

# Traffic Weight Variables (as specified in the prompt)
variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group. Specifies the percentage of traffic routed to the Blue environment."
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group. Specifies the percentage of traffic routed to the Green environment."
  type        = number
  default     = 0
}

# Tagging
variable "common_tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
}
