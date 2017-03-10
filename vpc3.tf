## VPC 3 + Subnets + igw3

resource "aws_vpc" "vpc3" {
  cidr_block           = "${var.VPC3_CIDR_PREFIX}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}-vpc"
  }
}

resource "aws_subnet" "pub3A" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.VPC3_CIDR_PREFIX}.1.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}.1-pubA"
  }
}

resource "aws_subnet" "pub3B" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.VPC3_CIDR_PREFIX}.2.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}.2-pubB"
  }
}

resource "aws_subnet" "priv3A" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.VPC3_CIDR_PREFIX}.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}.3-privA"
  }
}

resource "aws_subnet" "priv3B" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.VPC3_CIDR_PREFIX}.4.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}.4-privB"
  }
}

resource "aws_internet_gateway" "igw3" {
  vpc_id = "${aws_vpc.vpc3.id}"

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}-igw"
  }
}

resource "aws_route_table" "pub3RT" {
  vpc_id = "${aws_vpc.vpc3.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw3.id}"
  }

  route {
    cidr_block                = "${var.VPC1_CIDR_PREFIX}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1-3.id}"
  }

  tags {
    Name = "${var.VPC3_CIDR_PREFIX}-pubRT"
  }
}

resource "aws_route_table_association" "pub3A" {
  subnet_id      = "${aws_subnet.pub3A.id}"
  route_table_id = "${aws_route_table.pub3RT.id}"
}

resource "aws_route_table_association" "pub3B" {
  subnet_id      = "${aws_subnet.pub3B.id}"
  route_table_id = "${aws_route_table.pub3RT.id}"
}
