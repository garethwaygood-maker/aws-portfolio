resource "aws_cloudfront_origin_access_control" "portfolio" {
  name                              = "oac-gareth-waygood-aws-portfolio.s3.eu-west-2.amazon-mth5hhdy7zd"
  description                       = "Created by CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "portfolio" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_All"
  http_version        = "http2"

  aliases = [
    "aws.waygood.net"
  ]

  tags = {
    Name = "aws-portfolio-cloudfront"
  }

  origin {
    domain_name              = aws_s3_bucket.portfolio.bucket_regional_domain_name
    origin_id                = "gareth-waygood-aws-portfolio.s3.eu-west-2.amazonaws.com-mth5czrikj2"
    origin_access_control_id = aws_cloudfront_origin_access_control.portfolio.id

    connection_attempts         = 3
    connection_timeout          = 10
    response_completion_timeout = 0
  }

  default_cache_behavior {
    target_origin_id       = "gareth-waygood-aws-portfolio.s3.eu-west-2.amazonaws.com-mth5czrikj2"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    compress        = true
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.portfolio.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  web_acl_id = aws_wafv2_web_acl.portfolio.arn
}