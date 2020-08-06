provider "aws" {
   access_key = "<access_key>"
    secret_key = "<secret_key>" 
    region = "us-east-1"
}

resource "aws_vpc" "Hippo" {
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "default"
    tags = {
        "Name" = "TF"
    } 
}
