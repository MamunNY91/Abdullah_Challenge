
/*
output "db_host"{
    value = aws_db_instance.main.address
}
*/
output "ec2instance" {
  value = aws_instance.web-server.public_dns
}
output "ec2-ins-ip" {
  value = aws_instance.web-server.public_ip
}