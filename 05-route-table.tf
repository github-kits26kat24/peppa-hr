resource "aws_route_table" "nodes" {
  vpc_id = aws_vpc.prod.id # aws_vpc.hr-app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Nodes"
  }
}

# resource "aws_route_table" "public" {
#   #The Vpc Id
#   vpc_id = aws_vpc.ToolServer03.id

#   route {
#     #The CIDR Block Of The Route.
#     cidr_block = "0.0.0.0/0"

#     # Gateway_ID Identifier Of A Vpc Internet Gateway Or A Vitual Private Gateway.

#     gateway_id = aws_internet_gateway.Project03.id
#   }

#   # A Map Of Tags To Assign To The Resources.
#   tags = {
#     Name = "Kay-Public"
#   }
# }
# # resource "aws_route_table" "node-2" {
# #   vpc_id = aws_vpc.hr-app-vpc.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_internet_gateway.gw.id
# #   }

# #   tags = {
# #     Name = "Node-2"
# #   }
# # }