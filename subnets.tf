resource "aws_subnet" "Public" {
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Public}"
  tags {
        Name = "Public"
  }
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
}
resource "aws_route_table_association" "Public" {
    subnet_id = "${aws_subnet.Public.id}"
    route_table_id = "${aws_route_table.public.id}"
}
