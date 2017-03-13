## VPC 3 + Subnets + igw3

resource "aws_vpc" "vpc3" {
  cidr_block           = "${var.vpc3_cidr_prefix}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc3_cidr_prefix}-vpc"
  }
}

resource "aws_subnet" "pub_3a" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.vpc3_cidr_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.vpc3_cidr_prefix}.1-pub-a"
  }
}

resource "aws_subnet" "pub_3b" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.vpc3_cidr_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.vpc3_cidr_prefix}.2-pub-a"
  }
}

resource "aws_subnet" "priv_3a" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.vpc3_cidr_prefix}.3.0/24"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.vpc3_cidr_prefix}.3-priv-a"
  }
}

resource "aws_subnet" "priv_3b" {
  vpc_id            = "${aws_vpc.vpc3.id}"
  cidr_block        = "${var.vpc3_cidr_prefix}.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.vpc3_cidr_prefix}.4-priv-b"
  }
}

resource "aws_internet_gateway" "igw3" {
  vpc_id = "${aws_vpc.vpc3.id}"

  tags {
    Name = "${var.vpc3_cidr_prefix}-igw"
  }
}

resource "aws_route_table" "pub_3" {
  vpc_id = "${aws_vpc.vpc3.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw3.id}"
  }

  route {
    cidr_block                = "${var.vpc1_cidr_prefix}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1_3.id}"
  }

  tags {
    Name = "${var.vpc3_cidr_prefix}-pub"
  }
}

resource "aws_route_table_association" "pub_3a" {
  subnet_id      = "${aws_subnet.pub_3a.id}"
  route_table_id = "${aws_route_table.pub_3.id}"
}

resource "aws_route_table_association" "pub_3b" {
  subnet_id      = "${aws_subnet.pub_3b.id}"
  route_table_id = "${aws_route_table.pub_3.id}"
}
