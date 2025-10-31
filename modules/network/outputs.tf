output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# S3エンドポイントの紐づけ用
output "private_route_table_ids" {
  value = [aws_route_table.private.id]
}