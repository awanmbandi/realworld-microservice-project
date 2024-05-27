resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "pub_sub1" {
cidr_block = "192.168.1.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch = "true"
vpc_id = aws_vpc.vpc.id
 tags = {
    "kubernetes.io/cluster/ed-eks-01" = "shared"
  }
}

resource "aws_subnet" "pub_sub2" {
cidr_block = "192.168.2.0/24"
availability_zone = "us-east-1b"
vpc_id = aws_vpc.vpc.id
map_public_ip_on_launch = "true"
tags = {
    "kubernetes.io/cluster/ed-eks-01" = "shared"
  }
}

resource "aws_subnet" "priv_sub1" {
cidr_block = "192.168.3.0/24"
availability_zone = "us-east-1c"
vpc_id = aws_vpc.vpc.id
tags = {
    "kubernetes.io/cluster/ed-eks-01" = "shared"
  }
}

resource "aws_subnet" "priv_sub2" {
cidr_block = "192.168.4.0/24"
availability_zone = "us-east-1d"
vpc_id = aws_vpc.vpc.id
tags = {
    "kubernetes.io/cluster/ed-eks-01" = "shared"
  }
}


resource "aws_route_table" "priv_rt" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.vpc.id
}


resource "aws_route_table_association" "pub-sub1-rt-association" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.pub_sub1.id
}

resource "aws_route_table_association" "pub-sub2-rt-association" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.pub_sub2.id
}

resource "aws_route_table_association" "priv-sub1-rt-association" {
    route_table_id = aws_route_table.priv_rt.id
    subnet_id = aws_subnet.priv_sub1.id
}

resource "aws_route_table_association" "priv-sub2-rt-association" {
    route_table_id = aws_route_table.priv_rt.id
    subnet_id = aws_subnet.priv_sub2.id
}

resource "aws_route" "pub-rt" {
  route_table_id = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id

}
