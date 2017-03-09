#=======================
# VPC 2 + Subnets + igw2
#=======================

resource "aws_vpc" "vpc2" {
  cidr_block           = "${var.VPC2_CIDR_PREFIX}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.VPC2_NAME}-vpc"
  }
}

resource "aws_subnet" "public2A" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.VPC2_CIDR_PREFIX}.1.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC2_NAME}-public2A"
  }
}

resource "aws_subnet" "public2B" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.VPC2_CIDR_PREFIX}.2.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC2_NAME}-public2B"
  }
}

resource "aws_subnet" "private2A" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.VPC2_CIDR_PREFIX}.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC2_NAME}-private2A"
  }
}

resource "aws_subnet" "private2B" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.VPC2_CIDR_PREFIX}.4.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC2_NAME}-private2B"
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = "${aws_vpc.vpc2.id}"
}

resource "aws_route_table" "public2RT" {
  vpc_id = "${aws_vpc.vpc2.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw2.id}"
  }

  route {
    cidr_block = "${var.VPC1_CIDR_PREFIX}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1.id}"
  }

}

resource "aws_route_table_association" "public2A" {
  subnet_id      = "${aws_subnet.public2A.id}"
  route_table_id = "${aws_route_table.public2RT.id}"
}

resource "aws_route_table_association" "public2B" {
  subnet_id      = "${aws_subnet.public2B.id}"
  route_table_id = "${aws_route_table.public2RT.id}"
}
