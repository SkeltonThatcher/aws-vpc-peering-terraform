## VPC Peering connections

resource "aws_vpc_peering_connection" "vpc1-2" {
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
    Name = "VPC Peering between ${var.VPC1_CIDR_PREFIX}-vpc and ${var.VPC2_CIDR_PREFIX}-vpc"
  }
}

resource "aws_vpc_peering_connection" "vpc1-3" {
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
    Name = "VPC Peering between ${var.VPC1_CIDR_PREFIX}-vpc and ${var.VPC3_CIDR_PREFIX}-vpc"
  }
}
