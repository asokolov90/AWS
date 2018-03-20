# Configure the AWS Provider
variable "aws_access_key" {}
variable "aws_secret_key"{}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-2"
}

resource "aws_key_pair" "sokolov-key" {
  key_name   = "sokolov-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLIysh5oLuBddmbEpJAGfUQ7aOcfTGytGp46HFcMlUpYcEWeKwMK97QhuCgnCEamYDDoY7/tNyDL5psdrW5n0up/HfatvGCHfugEIQNl5zY0TSNFQRBoQ9+tBj0bNpBPDv/3oooGYfGlUK45MMYzrvL6/EIrK1MOdRW8z2JWVTOU23cOFeS24Edp3EIdcv8/o2NqnSIpSAB5KptmoBh22TqQMEbNfD+ymjNg1BB//BMtoOTnbO1oAQHcoG7cHVy3IS2R8glsJpz+UFiEakattGrUD3nTZcUrD3LpDXm2a7rkg1IUR4/cE3KVPQPROJWpUqHMuycBr9tPRop1iR+mVd root@BuRn1nG"
  }
resource "aws_instance" "web" {
  ami = "ami-25615740"
  key_name = "${aws_key_pair.sokolov-key.key_name}"
  instance_type = "t2.micro"
  count =1 
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.Public.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  
  tags {
        Name = "webserver"
        puppet_role = "base"
        CNAME = "puppet-agent.example.com."  
  }
  user_data = <<HEREDOC
  #!/bin/bash
  sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
  sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
  sudo yum install -y apache-maven
  sudo yum install -y git
HEREDOC
}
resource "aws_instance" "web2" {
  ami = "ami-25615740"
  key_name = "${aws_key_pair.sokolov-key.key_name}"
  instance_type = "t2.micro"
  count = 1
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.Public.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]

  tags {
        Name = "webserver2"
        puppet_role = "base"
        CNAME = "puppet-agent2.example.com."
  }
  user_data = <<HEREDOC
  #!/bin/bash
  sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
  sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
  sudo yum install -y apache-maven
  sudo yum install -y git
HEREDOC
}
# resource "aws_elb_attachment" "web" {
#	count = 2 
#	elb      = "${var.web_elb}"
#	instance = ["${aws_instance.web.*.id}"]
#}
