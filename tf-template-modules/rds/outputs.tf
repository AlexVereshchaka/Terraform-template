output "db_host" {
  description = "Hostname of the RDS instance"
  value       = aws_db_instance.db.endpoint
}

output "db_username" {
  description = "Username for the database"
  value       = var.db_username
}

output "db_password" {
  description = "Password for the database"
  value       = var.db_password
}
