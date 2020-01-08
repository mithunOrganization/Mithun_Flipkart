resource "aws_elb" "dev-app_elb" {
  name            = "${local.aws_elb_dev-app_ec2_elb_name}"
  subnets         = ["${data.aws_subnet_ids.trusted.ids}"]
  security_groups = ["${aws_security_group.ecs_elb.id}"]

  access_logs {
    bucket        = "${local.aws_elb_ec2_elb_bucket}"
    bucket_prefix = "${local.aws_elb_ec2_elb_bucket_prefix}"
    interval      = 60
  }


  internal = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 50
    target              = "HTTP:80/"
    interval            = 60
  }

  # backing instance port, so outgoing
  # Encryption - Data transmission - Internal NN - Closed Network (SRL_R-3, SRL_1.13)
  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "http"

  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name  = "dev-app-elb"
    Owner = "owner.email@email.com"
  }
}
