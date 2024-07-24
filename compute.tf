# Creates a security group that allows us to create 
# ingress rules allowing traffic for HTTP, HTTPS and SSH protocols from anywhere
# You may add additional ingress rules if you would like to expose your EC2
# from other ports and protocols
resource "aws_security_group" "ec2_sg" {
  name   = var.sg_name
  vpc_id = aws_vpc.my_vpc.id # var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# This code block allows us to create an ec2 instance with the use of variables
# To overwrite any one particular variable, we can pass the variable at runtime during terraform apply step
# e.g. terraform apply --var ec2_name="my-var-webserver"
resource "aws_instance" "sample_ec2_variables" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.my_public_subnet_az1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.ec2_name
  }
}