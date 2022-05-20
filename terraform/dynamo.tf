resource "aws_dynamodb_table" "ordersTable" {
  name           = var.orders_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = var.orders_table_hash_key

  attribute {
    name = var.orders_table_hash_key
    type = "S"
  }

  tags = {
    Name        = var.orders_table_name
  }
}