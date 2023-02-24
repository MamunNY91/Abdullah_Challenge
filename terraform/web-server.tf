

data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] 
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_instance" "web-server" {
    ami = data.aws_ami.ubuntu-linux-2004.id
    instance_type = "t2.micro"
    
    key_name = aws_key_pair.key_pair.key_name
    vpc_security_group_ids = [aws_security_group.web-server-sg.id]
    subnet_id = aws_subnet.public_a.id
    tags = merge(
        local.common_tags,
        tomap({"Name"= "${local.prefix}-django"})
    )
}



resource "aws_security_group" "web-server-sg"{
    description= "control webservers inbound and outbound access"
    name = "${local.prefix}-server"
    vpc_id = aws_vpc.main.id
    ingress{
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress{
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress{
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }
  
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
    tags = local.common_tags
}
