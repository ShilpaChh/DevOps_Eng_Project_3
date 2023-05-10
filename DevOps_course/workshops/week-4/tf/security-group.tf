data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_vpc" "default" {
  default = "true"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_ssh ${random_id.tag.hex}"
    Group = random_id.tag.hex
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group" "allow_http_3000" {
  name        = "allow_http_3000"
  description = "Allow HTTP inbound traffic on port 3000"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_http_3000 ${random_id.tag.hex}"
    Group = random_id.tag.hex
  }
}

resource "aws_security_group_rule" "allow_http_3000" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  security_group_id = aws_security_group.allow_http_3000.id
}