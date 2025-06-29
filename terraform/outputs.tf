output "instance_id" {
  value = aws_instance.devops_instance.id
}

output "instance_public_ip" {
  value = aws_instance.devops_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.devops_instance.private_ip
}
output "private_key_file" {
  description = "Path to the generated private key file"
  value       = local_file.private_key.filename
}

output "key_pair_name" {
  value = aws_key_pair.assignment.key_name
}
