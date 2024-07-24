variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0b72821e2f351e396"
}

variable "ec2_name" {
  description = "Name of EC2"
  type        = string
  default     = "luqman-tf-ec2" # Replace with your preferred EC2 Instance Name 
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of EC2 Key Pair"
  type        = string
  default     = "luqman-useast1-13072024" # Replace with your own key pair name (without .pem extension) that you have downloaded from AWS console previously
}

variable "sg_name" {
  description = "Name of EC2 security group"
  type        = string
  default     = "luqman-tf-sg-allow-ssh-http-https" # Replace with your own preferred security group name that gives an overview of the security group coverage
}