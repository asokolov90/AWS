resource "aws_elb" "web" {
  name               = "web-terraform-elb"
  availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]

  access_logs {
    bucket        = "web"
    bucket_prefix = ""
    interval      = 60
  }

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
# instances = ["${aws_instance.web.id}",["${aws_instance.web2.id}"]]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "web-terraform-elb"
  }
}
