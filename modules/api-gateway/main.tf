resource "aws_api_gateway_rest_api" "example_api" {
  name        = var.name
  description = var.description
}

resource "aws_api_gateway_resource" "example_resource" {
  for_each = var.resources

  rest_api_id = aws_api_gateway_rest_api.example_api.id
  parent_id   = each.value.parent_id
  path_part   = each.value.path_part
}

resource "aws_api_gateway_method" "example_method" {
  for_each = var.methods

  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_resource.example_resource[each.value.resource_name].id
  http_method   = each.value.http_method
  authorization = each.value.authorization
}

resource "aws_api_gateway_integration" "example_integration" {
  for_each = var.integrations

  rest_api_id             = aws_api_gateway_rest_api.example_api.id
  resource_id             = aws_api_gateway_resource.example_resource[each.value.resource_name].id
  http_method             = each.value.http_method
  integration_http_method = each.value.integration_http_method
  type                    = each.value.type
  uri = each.value.uri
}

resource "aws_lambda_permission" "allow_api" {
  for_each = var.lambda_functions
  
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name =  each.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    =  each.source_arn
}

resource "aws_api_gateway_deployment" "example_deployment" {
  depends_on = [aws_api_gateway_integration.example_integration]

  for_each = var.deployments

  rest_api_id = aws_api_gateway_rest_api.example_api.id
  stage_name  = each.value.stage_name
}
