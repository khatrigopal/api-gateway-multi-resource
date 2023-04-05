variable "name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "description" {
  type        = string
  description = "The description of the API Gateway"
}

variable "resources" {
  type        = map(object({
    parent_id = string
    path_part = string
  }))
  description = "The resources to create for the API Gateway"
}

variable "methods" {
  type        = map(object({
    resource_name = string
    http_method   = string
    authorization = string
  }))
  description = "The HTTP methods to create for the API Gateway resources"
}

variable "integrations" {
  type        = map(object({
    resource_name           = string
    http_method             = string
    integration_http_method = string
    type                    = string
    uri                     = string
  }))
  description = "The integrations to create for the API Gateway resources"
}

variable "deployments" {
  type        = map(object({
    stage_name = string
  }))
  description = "The deployments to create for the API Gateway"
}
