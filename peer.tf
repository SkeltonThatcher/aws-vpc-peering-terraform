## VPC Peering connection

resource "aws_vpc_peering_connection" "vpc1" {
    peer_vpc_id = "${aws_vpc.vpc2.id}"
    vpc_id = "${aws_vpc.vpc1.id}"
    auto_accept = true

    accepter {
      allow_remote_vpc_dns_resolution = true
    }

    requester {
      allow_remote_vpc_dns_resolution = true
    }

    tags {
      Name = "VPC Peering between vpc1 and vpc2"
    }
}