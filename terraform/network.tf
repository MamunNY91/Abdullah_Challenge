resource "aws_vpc" "main"{
    cidr_block = "10.1.0.0/16"
    enable_dns_support = true 
    enable_dns_hostnames = true
    tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-vpc"})
    )
}
resource "aws_internet_gateway" "main"{
    vpc_id = aws_vpc.main.id
    tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-main"})
    )
}
resource "aws_subnet" "public_a" {
     cidr_block = "10.1.1.0/24"
     map_public_ip_on_launch = true 
     vpc_id = aws_vpc.main.id
     availability_zone = "${data.aws_region.current.name}a"
      tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-public-a"})
    )

}
resource "aws_route_table" "public_a"{
    vpc_id = aws_vpc.main.id
    route{
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
     tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-public-a"})
    )
}
resource "aws_route_table_association" "public_a"{
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public_a.id
}
resource "aws_subnet" "public_b" {
     cidr_block = "10.1.2.0/24"
     map_public_ip_on_launch = true 
     vpc_id = aws_vpc.main.id
     availability_zone = "${data.aws_region.current.name}b"
      tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-public-b"})
    )

}
resource "aws_route_table" "public_b"{
    vpc_id = aws_vpc.main.id
    route{
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
     tags = merge(
        local.common_tags, tomap({"Name"="${local.prefix}-public-b"})
    )
}
resource "aws_route_table_association" "public_b"{
    subnet_id = aws_subnet.public_b.id
    route_table_id = aws_route_table.public_b.id
}