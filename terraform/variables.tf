variable "application_payload_name" {
  type    = string
  default = "application_payload.zip"
}


variable "build_location" {
  type    = string
  default = "../build/"
}

variable "orders_table_name" {
  type = string
  default = "Orders"
}


variable "orders_table_hash_key" {
  type = string
  default = "COUNTER"
}