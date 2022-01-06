# VPC
resource "aws_vpc" "dev_pro_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "dev_pro_gw" {
  vpc_id = aws_vpc.dev_pro_vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# EIP + NAT gateway
resource "aws_eip" "dev_pro_nat_gw_eip" {
  vpc = true

  tags = {
    Name = "${var.env}-nat_gw_eip"
  }
}

resource "aws_nat_gateway" "dev_pro_nat_gw" {
  allocation_id = aws_eip.dev_pro_nat_gw_eip.id
  subnet_id     = aws_subnet.dev_pro_public_subnets[0].id

  tags = {
    Name = "${var.env}-nat_gw"
  }

  depends_on = [aws_internet_gateway.dev_pro_gw, aws_eip.dev_pro_nat_gw_eip]
}

# subnets
resource "aws_subnet" "dev_pro_public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.dev_pro_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "dev_pro_private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.dev_pro_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.env}-private-${count.index + 1}"
  }
}

resource "aws_subnet" "dev_pro_database_subnets" {
  count             = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.dev_pro_vpc.id
  cidr_block        = element(var.database_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.env}-database-${count.index + 1}"
  }
}


# route tables
resource "aws_route_table" "dev_pro_public_subnets_rt" {
  vpc_id = aws_vpc.dev_pro_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_pro_gw.id
  }

  tags = {
    Name = "${var.env}-rt-public-subnets"
  }
}

resource "aws_route_table" "dev_pro_private_subnets_rt" {
  vpc_id = aws_vpc.dev_pro_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_pro_nat_gw.id
  }

  tags = {
    Name = "${var.env}-rt-private-subnets"
  }
}

resource "aws_route_table" "dev_pro_database_subnets_rt" {
  vpc_id = aws_vpc.dev_pro_vpc.id

  tags = {
    Name = "${var.env}-rt-database-subnets"
  }
}

resource "aws_route_table_association" "dev_pro_public_routes" {
  count          = length(aws_subnet.dev_pro_public_subnets[*].id)
  route_table_id = aws_route_table.dev_pro_public_subnets_rt.id
  subnet_id      = element(aws_subnet.dev_pro_public_subnets[*].id, count.index)

}

resource "aws_route_table_association" "dev_pro_private_routes" {
  count          = length(aws_subnet.dev_pro_private_subnets[*].id)
  route_table_id = aws_route_table.dev_pro_private_subnets_rt.id
  subnet_id      = element(aws_subnet.dev_pro_private_subnets[*].id, count.index)

}

resource "aws_route_table_association" "dev_pro_database_routes" {
  count          = length(aws_subnet.dev_pro_database_subnets[*].id)
  route_table_id = aws_route_table.dev_pro_database_subnets_rt.id
  subnet_id      = element(aws_subnet.dev_pro_database_subnets[*].id, count.index)

}
