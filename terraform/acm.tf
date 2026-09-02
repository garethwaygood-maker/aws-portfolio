resource "aws_acm_certificate" "portfolio" {
  provider = aws.us_east_1

  domain_name       = "aws.waygood.net"
  validation_method = "DNS"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
}