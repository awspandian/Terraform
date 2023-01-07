resource "aws_vpc" "Hippovpc" {
    cidr_block = var.cidr_block  
    tags = {
      "Name" = "Hippo_vpc"
    }
}

resource "aws_subnet" "subnets" {
    count = 3
    cidr_block = var.subnet_cidrs[count.index]
    vpc_id = aws_vpc.Hippovpc.id
    tags = {
      "Name" = var.subnet_name_tags[count.index]
    }
  
}