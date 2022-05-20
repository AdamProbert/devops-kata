resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "dynamo_order_getItem_policy" {
  name        = "dynamo_order_getItem_policy"
  path        = "/"
  description = "A policy for getting items from the Dynamo Orders table"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "dynamodb:GetItem",
        "Resource" : aws_dynamodb_table.ordersTable.arn
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "dynamo_order_getItem_policy_attachment" {
  name       = "dynamo_order_getItem_policy_attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.dynamo_order_getItem_policy.arn
}





resource "aws_iam_role" "write_iam_for_lambda" {
  name = "write_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "dynamo_order_updateItem_policy" {
  name        = "dynamo_order_updateItem_policy"
  path        = "/"
  description = "A policy for updating items in the Dynamo Orders table"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "dynamodb:UpdateItem",
        "Resource" : aws_dynamodb_table.ordersTable.arn
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "dynamo_order_updateItem_policy_attachment" {
  name       = "dynamo_order_updateItem_policy_attachment"
  roles      = [aws_iam_role.write_iam_for_lambda.name]
  policy_arn = aws_iam_policy.dynamo_order_updateItem_policy.arn
}