# ==========================================================================
#  Resources: RDS laravel-app / dns.tf (DNS RDS)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Zone ID (DNS)
#    - Route53 Record
# ==========================================================================

# Use Hosted Zone id for zx.in
data "aws_route53_zone" "this" {
  zone_id = "YOUR_DNS_ZONE_ID"
}

locals {
  domain      = "${module.db.db_instance_id}-db.${data.aws_route53_zone.this.name}"
  domain_name = trimsuffix(local.domain, ".")
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = local.domain_name
  type    = "CNAME"
  ttl     = 300
  records = ["${module.db.db_instance_address}"]
}