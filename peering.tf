## VPC Peering connections

resource "aws_vpc_peering_connection" "vpc1_2" {
  peer_vpc_id = "${aws_vpc.vpc2.id}"
  vpc_id      = "${aws_vpc.vpc1.id}"
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    Name = "VPC Peering between ${var.vpc1_cidr_prefix}-vpc and ${var.vpc2_cidr_prefix}-vpc"
  }
}

resource "aws_vpc_peering_connection" "vpc1_3" {
  peer_vpc_id = "${aws_vpc.vpc3.id}"
  vpc_id      = "${aws_vpc.vpc1.id}"
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    Name = "VPC Peering between ${var.vpc1_cidr_prefix}-vpc and ${var.vpc3_cidr_prefix}-vpc"
  }
}
