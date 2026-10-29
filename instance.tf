resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_sn.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name              = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    set -e

    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-id)
    INSTANCE_TYPE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-type)
    AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/placement/availability-zone)
    PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/public-ipv4)

    mkdir -p /var/www/html
    cat > /var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html>
    <head><title>Instance Info</title></head>
    <body>
      <h1>Instance Metadata</h1>
      <ul>
        <li>Instance ID: $${INSTANCE_ID}</li>
        <li>Instance Type: $${INSTANCE_TYPE}</li>
        <li>Availability Zone: $${AZ}</li>
        <li>Public IP: $${PUBLIC_IP}</li>
      </ul>
    </body>
    </html>
    HTML

    nohup python3 -m http.server 80 --directory /var/www/html &
  EOF

  tags = merge(local.common_tags, { Name = "${var.project_name}-web" })
}   