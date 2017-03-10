## VPC 1 + Subnets + igw1

resource "aws_vpc" "vpc1" {
  cidr_block           = "${var.VPC1_CIDR_PREFIX}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}-vpc"
  }
}

resource "aws_subnet" "pub1A" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.1.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}.1-pubA"
  }
}

resource "aws_subnet" "pub1B" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.2.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}.2-pubB"
  }
}

resource "aws_subnet" "priv1A" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}.3-privA"
  }
}

resource "aws_subnet" "priv1B" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  cidr_block        = "${var.VPC1_CIDR_PREFIX}.4.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}.4-privB"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}-igw"
  }
}

resource "aws_route_table" "pub1RT" {
  vpc_id = "${aws_vpc.vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw1.id}"
  }

  route {
    cidr_block                = "${var.VPC2_CIDR_PREFIX}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1-2.id}"
  }

  route {
    cidr_block                = "${var.VPC3_CIDR_PREFIX}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1-3.id}"
  }

  tags {
    Name = "${var.VPC1_CIDR_PREFIX}-pubRT"
  }
}

resource "aws_route_table_association" "pub1A" {
  subnet_id      = "${aws_subnet.pub1A.id}"
  route_table_id = "${aws_route_table.pub1RT.id}"
}

resource "aws_route_table_association" "pub1B" {
  subnet_id      = "${aws_subnet.pub1B.id}"
  route_table_id = "${aws_route_table.pub1RT.id}"
}
