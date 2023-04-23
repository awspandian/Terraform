resource "aws_vpc" "ck_vpc" {
  cidr_block           = "10.100.0.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "CKVPC"
  }

}
resource "aws_subnet" "ck_vpc_subnet" {
  vpc_id                  = aws_vpc.ck_vpc.id
  cidr_block              = "10.100.0.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "CK-SN1"
  }

}
resource "aws_subnet" "ck_vpc_subnet2" {
  vpc_id            = aws_vpc.ck_vpc.id
  cidr_block        = "10.100.0.16/28"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "CK-SN2"
  }

}

resource "aws_internet_gateway" "ck_igw" {
  vpc_id = aws_vpc.ck_vpc.id

  tags = {
    "Name" = "CK-IGW"
  }

}

resource "aws_route_table" "ck_pub_rt" {
  vpc_id = aws_vpc.ck_vpc.id

  tags = {
    "Name" = "CK_Pub_RT"
  }

}

resource "aws_route" "ck_route" {
  route_table_id         = aws_route_table.ck_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ck_igw.id

}

resource "aws_route_table_association" "ck_pub_assoc" {
  subnet_id      = aws_subnet.ck_vpc_subnet.id
  route_table_id = aws_route_table.ck_pub_rt.id

}
resource "aws_security_group" "ck_sg" {
  name        = "CK_SG"
  description = "ck security group"
  vpc_id      = aws_vpc.ck_vpc.id

  ingress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "terraform_key" {
    key_name = "CK_terrakey"
    public_key = file("~/.ssh/terrafrom_key.pub")
  
}
resource "aws_instance" "CK_jump_server1" {
    instance_type = "t2.micro"
    ami = data.aws_ami.CK_Jump_Server.id
    key_name = aws_key_pair.terraform_key.id
    vpc_security_group_ids = [aws_security_group.ck_sg.id]
    subnet_id = aws_subnet.ck_vpc_subnet.id
    user_data = file("userdata.tpl")

    root_block_device {
      volume_size = 10
    }

    tags = {
      "Name" = "CJ-Jump-Server1"
    }
    provisioner "local-exec" {
        command = templatefile("windows-ssh-config.tpl", {
            hostname = self.public_ip,
            user = "ubuntu",
            identityfile = "~/.ssh/CK_terrakey"
        })
        interpreter = ["Powershell", "-Command"]
        # interpreter = ["bash" , "-c"]
          
    }
 
}