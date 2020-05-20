resource "aws_cloudwatch_log_group" "default" {
  name = "${var.project_name}-logs"
  tags = local.tags
}

resource "aws_cloudwatch_log_resource_policy" "logging" {
  policy_name     = "${var.project-name}-logging-policy"
  policy_document = data.aws_iam_policy_document.logging.json
}

data "aws_iam_policy_document" "logging" {
  statement {

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream"
    ]

    resources = [
      "arn:aws:logs:*"
    ]
  }
}