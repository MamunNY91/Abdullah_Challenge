provider "aws"{
    region = "us-east-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
   
}
locals{
    prefix ="${var.prefix}-${terraform.workspace}"
    common_tags ={
        Environment = terraform.workspace
        Project = var.project
        Owner = var.contact
        ManagedBy = "Terraform"
    }
}
data "aws_region" "current"{
    
}
