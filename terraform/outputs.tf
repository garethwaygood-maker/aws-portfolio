output "website_url" {
  value = "https://aws.waygood.net"
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.portfolio.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.portfolio.bucket
}