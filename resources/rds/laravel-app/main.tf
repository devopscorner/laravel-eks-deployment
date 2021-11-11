# ==========================================================================
#  Resources: RDS laravel-app / main.tf (Main Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - VPC References
#    - Route53 Record
#    - Security Group
#    - Database Configuration
# ==========================================================================

provider "aws" {
  region = "ap-southeast-1"
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "devopscorner_vpc" {
  id = "vpc-YOUR_VPC_ID"
}

# NOTE: by default only selecting nonk8s private subnet
# Update tags selection if would like to choose other subnet
data "aws_subnet_ids" "devopscorner_subnet" {
  vpc_id = data.aws_vpc.devopscorner_vpc.id
}

## Create New Security Group for DB Production
resource "aws_security_group" "default" {
  name        = "devopscorner-sg-rds-laravel-app-staging"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.devopscorner_vpc.id
  ingress {
    description      = "PostgreSQL Port"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0","10.34.0.0/20","10.35.0.0/20"]
    ipv6_cidr_blocks = ["::/0"]
    #security_groups  = ["sg-YOUR_SECURITY_GROUPID"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.dev_tags
}

#####
# DB
#####
module "db" {
  source = "../../../modules/terraform-aws-rds"

  identifier        = "laravel-app-staging"
  engine            = "postgres"
  engine_version    = "12.8"
  instance_class    = "db.t3.medium"
  allocated_storage = 100
  storage_encrypted = true
  kms_key_id        = "YOUR_KMS_ID"

  # DB_NAME
  name     = "laravel-app"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"

  # DB_USER
  username = "postgres"
  # DB_PASSWORD
  password = "YOUR_DB_PASSWORD"
  # DB_PORT
  port     = "5432"

  vpc_security_group_ids = [aws_security_group.default.id]

  # disable backups to create DB faster
  backup_retention_period = 7

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = var.dev_tags

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # DB subnet group
  subnet_ids = ["subnet-SUBNET_ID_1","subnet-SUBNET_ID_2"]

  # DB parameter group
  family = "postgres12"

  # DB option group
  major_engine_version = "12"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "laravel-app-staging"

  # Database Deletion Protection
  deletion_protection = true

  # ######
  # # ONLY USE THIS IF WANT TO RESTORE DB FROM SNAPSHOT
  # ######
  # # Use DB Snapshot Name inside RDS Console -> Snapshots for snapshot_identifier
  # snapshot_identifier = "sharedprojects-20210506"
  # copy_tags_to_snapshot = true
}
