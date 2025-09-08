module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.18.1"

  name            = local.name
  cidr            = local.vpc_cidr
  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  one_nat_gateway_per_az = false

  enable_flow_log         = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  flow_log_log_group_name = "/aws/vpc/flow-logs"
  flow_log_log_group_retention_in_days = 7


  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "Environment"            = "Dev"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "Environment"                     = "Dev"
  }

  map_public_ip_on_launch = true
  enable_flow_log         = true
  tags                    = local.tags
}
