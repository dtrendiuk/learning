# cloudflare infrastructure
resource "cloudflare_record" "cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain
  value   = aws_alb.dev_pro_alb.dns_name
  type    = "CNAME"
  proxied = true
}
