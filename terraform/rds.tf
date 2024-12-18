resource "aws_db_instance" "three-tier-db" {
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "8.0.32"  # Use a different version
  instance_class      = "db.t4g.micro"  # Use a supported instance type
  identifier          = "three-tier-db"
  username            = "admin"
  password            = "samveg1234"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id
  vpc_security_group_ids = [aws_security_group.three_tier_sg.id]
  db_name = "myDB"
  multi_az            = true
  skip_final_snapshot = true
  publicly_accessible = false

}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = [aws_subnet.privat_sub_3.id,aws_subnet.privat_sub_4.id]
  depends_on = [ aws_subnet.privat_sub_3,aws_subnet.privat_sub_4 ]

  tags = {
    Name = "My DB subnet group"
  }
}
