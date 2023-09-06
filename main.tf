provider "aws" {
  region = "ap-south-2" # Replace with your desired AWS 
  profile = "terraform-user"

}

# Get existing VPC ID
data "aws_vpc" "existing_vpc" {
  id = "vpc-0a697b2cbf0e90b91" 
}

# Create subnets in existing VPC
resource "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.existing_vpc.id 
  cidr_block        = "172.35.0.0/18"
  availability_zone = "ap-south-2a"

  tags = {
    Name = "Subnet 1"
  }
} 

resource "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.35.64.0/18"
  availability_zone = "ap-south-2b"

  tags = {
    Name = "Subnet 2"
  }
}
#setup

resource "aws_subnet" "subnet_3" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.35.128.0/18"
  availability_zone = "ap-south-2c"

  tags = {
    Name = "Subnet 3"
  }
}


# RDS subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  tags = {
    Name = "My RDS subnet group"
  }
}
