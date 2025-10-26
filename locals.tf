locals {
  blue_user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
    chown apache:apache /var/www/html/index.html
    EOT

  green_user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
    chown apache:apache /var/www/html/index.html
    EOT
}
