resource "aws_vpc_endpoint" "this" {
  vpc_id            = var.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name      = var.service_name
  route_table_ids   = var.route_table_ids

  tags = {
    Name = "${var.project_name}-s3-gateway-endpoint"
  }
}