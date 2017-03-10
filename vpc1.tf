## VPC 1 + Subnets + igw1

resource "aws_vpc" "vpc1" {
  cidr_block           = "${var.VPC1_CIDR_PREFIX}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.VPC1_NAME}-vpc"
  }
}

resource "aws_subnet" "public1A" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.1.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC1_NAME}-public1A"
  }
}

resource "aws_subnet" "public1B" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.2.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC1_NAME}-public1B"
  }
}

resource "aws_subnet" "private1A" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC1_NAME}-private1A"
  }
}

resource "aws_subnet" "private1B" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.4.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC1_NAME}-private1B"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = "${aws_vpc.vpc1.id}"
}

resource "aws_route_table" "public1RT" {
  vpc_id = "${aws_vpc.vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw1.id}"
  }

  route {
    cidr_block = "${var.VPC2_CIDR_PREFIX}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1.id}"
  }
}

resource "aws_route_table_association" "public1A" {
  subnet_id      = "${aws_subnet.public1A.id}"
  route_table_id = "${aws_route_table.public1RT.id}"
}

resource "aws_route_table_association" "public1B" {
  subnet_id      = "${aws_subnet.public1B.id}"
  route_table_id = "${aws_route_table.public1RT.id}"
}
