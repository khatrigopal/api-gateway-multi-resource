module "example_api_gateway" {
  source = "./api_gateway_module"

  name        = "example-api"
  description = "Example API Gateway REST API"

  resources = {
    "resource1" = {
      parent_id = aws_api_gateway_rest_api.example_api.root_resource_id
      path_part = "resource1"
    }
    "resource2" = {
      parent_id = aws_api_gateway_resource.example_resource["resource1"].id
      path_part = "resource2"
    }
  }

  methods = {
    "method1" = {
      resource_name = "resource1"
      http_method   = "POST"
      authorization = "NONE"
    }
    "method2" = {
      resource_name = "resource2"
      http_method   = "POST"
      authorization = "NONE"
    }
  }

  integrations = {
    "integration1" = {
      resource_name           = "resource1"
      http_method             = "POST"
      integration_http_method = "POST"
      type                    = "AWS_PROXY"
      uri                     = "arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:123456789012:function:example-lambda-function/invocations"
    }
    "integration2" = {
      resource_name           = "resource2"
      http_method             = "POST"
      integration_http_method = "POST"
      type                    = "AWS_PROXY"
      uri                     = "arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:123456789012:function:example-lambda-function/invocations"
    }
  }

  deployments = {
    "dev" = {
      stage_name = "dev"
    }
    "prod" = {
      stage_name = "prod"
    }
  }
}
