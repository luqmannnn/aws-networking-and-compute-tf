locals {
  resource_prefix = "luqman-tf"
}

data "aws_ami" "linux2023" {
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}

output "ami_id" {
  value = data.aws_ami.linux2023.id
}

resource "aws_instance" "public" {
  ami                         = data.aws_ami.linux2023.id #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.existing_ce9_pub_subnet.id
  associate_public_ip_address = true
  key_name                    = "luqman-test-keypair" #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 
  tags = {
    Name = "${ local.resource_prefix }-ec2-${ var.env }" 
  }
}

output "ec2_public_ip" {
  value = aws_instance.public.public_ip
}

resource "aws_security_group" "allow_ssh" {
  name        = "${ local.resource_prefix }-security-group-ssh" #Security group name, e.g. jazeel-terraform-security-group
  description = "Allow SSH inbound"
  vpc_id      = data.aws_vpc.existing_ce9_vpc.id # vpc-0424f09862acfcf28
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
