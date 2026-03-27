resource "aws_sns_topic" "node_scaling_topic" {
  name = "${var.env}-${var.cluster_name}-node-scaling-topic"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-${var.cluster_name}-node-scaling-topic"
    }
  )
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.node_scaling_topic.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_event_rule" "mng_scaling_rule" {
  name        = "${var.env}-${var.cluster_name}-mng-scaling-rule"
  description = "Capture scaling events for ASG autoscaling alerts of EKS MNG"

  event_pattern = jsonencode({
    source = ["aws.autoscaling"]
    detail-type = [
      "EC2 Instance Launch Successful",
      "EC2 Instance Launch Unsuccessful",
      "EC2 Instance Terminate Successful",
      "EC2 Instance Terminate Unsuccessful"
    ]
    detail = {
      AutoScalingGroupName = [var.mng_asg_name]
    }
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-${var.cluster_name}-mng-scaling-rule"
    }
  )
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.mng_scaling_rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.node_scaling_topic.arn

  input_transformer {
    input_paths = {
      event_type  = "$.detail-type"
      action      = "$.detail.Action"
      asg_name    = "$.detail.AutoScalingGroupName"
      instance_id = "$.detail.EC2InstanceId"
      az          = "$.detail.Details.Availability Zone"
      subnet_id   = "$.detail.Details.Subnet ID"
      event_time  = "$.time"
      status_code = "$.detail.StatusCode"
      cause       = "$.detail.Cause"
    }

    input_template = <<EOF
{
  "message": "[EKS Node Scaling Alert]\\n\\nCluster: ${var.env}-${var.cluster_name}\\nEvent Type: <event_type>\\nAction: <action>\\nASG: <asg_name>\\nInstance: <instance_id>\\nAZ: <az>\\nSubnet: <subnet_id>\\nTime: <event_time>\\nStatus: <status_code>\\n\\nCause:\\n<cause>"
}
EOF
  }
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    sid    = "AllowEventBridgePublish"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sns:Publish"]

    resources = [aws_sns_topic.node_scaling_topic.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.mng_scaling_rule.arn]
    }
  }
}

resource "aws_sns_topic_policy" "mng_scaling_topic_policy" {
  arn    = aws_sns_topic.node_scaling_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
