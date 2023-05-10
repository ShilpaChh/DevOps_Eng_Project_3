data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon-linux.id
  instance_type   = "t2.micro"
  key_name        = "my-key-pair-name" # Change this!
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "config management workshop instance ${random_id.tag.hex}"
    Group = random_id.tag.hex
  }
}