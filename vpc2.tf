## VPC 2 + Subnets + igw2

resource "aws_vpc" "vpc2" {
  cidr_block           = "${var.vpc2_cidr_prefix}.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc2_cidr_prefix}-vpc"
  }
}

resource "aws_subnet" "pub_2a" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.vpc2_cidr_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.vpc2_cidr_prefix}.1-pub-a"
  }
}

resource "aws_subnet" "pub_2b" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.vpc2_cidr_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.vpc2_cidr_prefix}.2-pub-b"
  }
}

resource "aws_subnet" "priv_2a" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.vpc2_cidr_prefix}.3.0/24"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.vpc2_cidr_prefix}.3-priv-a"
  }
}

resource "aws_subnet" "priv_2b" {
  vpc_id            = "${aws_vpc.vpc2.id}"
  cidr_block        = "${var.vpc2_cidr_prefix}.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.vpc2_cidr_prefix}.4-priv-b"
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name = "${var.vpc2_cidr_prefix}-igw"
  }
}

resource "aws_route_table" "pub_2" {
  vpc_id = "${aws_vpc.vpc2.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw2.id}"
  }

  route {
    cidr_block                = "${var.vpc1_cidr_prefix}.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc1_2.id}"
  }

  tags {
    Name = "${var.vpc2_cidr_prefix}-pub"
  }
}

resource "aws_route_table_association" "pub_2a" {
  subnet_id      = "${aws_subnet.pub_2a.id}"
  route_table_id = "${aws_route_table.pub_2.id}"
}

resource "aws_route_table_association" "pub_2b" {
  subnet_id      = "${aws_subnet.pub_2b.id}"
  route_table_id = "${aws_route_table.pub_2.id}"
}
