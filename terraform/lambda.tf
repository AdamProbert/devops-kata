data "archive_file" "application_zip" {
  type        = "zip"
  source_dir  = "../app"
  output_path = "../build/${var.application_payload_name}"
}

resource "aws_lambda_function" "getCountOfSold_lambda" {

  filename      = "${var.build_location}${var.application_payload_name}"
  function_name = "getCountOfSold"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "handler.getCountOfSold"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${var.build_location}${var.application_payload_name}")

  runtime = "nodejs12.x"

  environment {
    variables = {
      DYNAMODB_TABLE = var.orders_table_name
    }
  }
}

resource "aws_lambda_function" "updateVehicleSales_lambda" {

  filename      = "${var.build_location}${var.application_payload_name}"
  function_name = "updateVehicleSales"
  role          = aws_iam_role.write_iam_for_lambda.arn
  handler       = "handler.updateVehicleSales"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${var.build_location}${var.application_payload_name}")

  runtime = "nodejs12.x"

  environment {
    variables = {
      DYNAMODB_TABLE = var.orders_table_name
    }
  }
}