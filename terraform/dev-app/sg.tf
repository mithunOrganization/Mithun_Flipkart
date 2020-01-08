resource "aws_security_group" "ecs_elb" {
  name_prefix = "${local.aws_security_group_dev-app_ec2_elb_name}"

  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Name  = "sg-elb-dev-app"
    Owner = "owner_email@email.com"
  }
}

resource "aws_security_group_rule" "elb_egress_http_80" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "ingress"

  from_port = 80

  to_port = 80

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "ssh_22" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "ingress"

  from_port = 22

  to_port = 22

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_egress_dck_port_egress" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "egress"

  from_port = 1

  to_port = 65535

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_egress_http_443_ingress" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "ingress"

  from_port = 443

  to_port = 443

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_egress_http_443_egress" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "egress"

  from_port = 443

  to_port = 443

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_egress_http_5000_egress" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "egress"

  from_port = 5000

  to_port = 5000

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_igress_http_80_ingress" {
  security_group_id = "${aws_security_group.ecs_elb.id}"

  type = "egress"

  from_port = 80

  to_port = 80

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}