resource "aws_route53_record" "portfolio_a" {
  zone_id = "Z06029927TI3CWVLZ1VG"
  name    = "aws.waygood.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "portfolio_aaaa" {
  zone_id = "Z06029927TI3CWVLZ1VG"
  name    = "aws.waygood.net"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}