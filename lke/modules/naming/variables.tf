variable "environment" {
  description = "environment (prod, stage, dev, ...)"
  type        = string
  default     = "prod"
}

variable "project" {
  description = "name of project"
  type        = string

  validation {
    condition     = length(var.project) < 11
    error_message = "length of project name should be less than 10 words."
  }
}