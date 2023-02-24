variable "prefix"{
    default ="dev-ops-skill-challenge"
}

variable "project"{
    default = "dev-ops-skill-challenge"
}
variable "contact"{
    default = "contact@a-mamun.dev"
}
variable "server_key_name"{
    default = "testInstance"
}

/*

variable "db_username"{
    type = string
  description = "Enter DB Username , use this value in envVars.env file"
}
variable "db_password"{
     type = string
     description = "Enter DB Password, use this value in envVars.env file"
}
*/
variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

