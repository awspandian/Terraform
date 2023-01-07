resource "aws_vpc" "Hippovpc" {
    cidr_block = var.cidr_block  
    tags = {
      "Name" = "Hippo_vpc"
    }
}

resource "aws_subnet" "subnets" {
    count = length(var.subnet_cidrs)
    cidr_block = var.subnet_cidrs[count.index]
    vpc_id = aws_vpc.Hippovpc.id
    availability_zone = var.subnet_azs[count.index]
    tags = {
      "Name" = var.subnet_name_tags[count.index]
    }
    depends_on = [
        aws_vpc.Hippovpc
      
    ]
  
}