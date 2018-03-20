resource "aws_vpc" "terraformmain" {
    cidr_block = "${var.vpc-fullcidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
      Name = "SpringB vpc"
    }
}
