# Terraform -- AWS Portfolio Infrastructure

This directory contains the Terraform configuration for **Project 01 --
Secure AWS Static Portfolio**.

Live site: **https://aws.waygood.net**

The infrastructure was originally built manually in the AWS Management
Console to develop an understanding of each AWS component. Terraform was
then introduced afterwards, with the existing production resources
imported into Terraform state rather than recreated.

This allowed the live infrastructure to be brought under Infrastructure
as Code management without disrupting the website.

## Architecture

The Terraform configuration manages the AWS infrastructure supporting
the portfolio website:

    Users
      |
      v
    Route 53
      |
      v
    CloudFront
      |
      +-- AWS WAF
      |
      +-- ACM TLS Certificate
      |
      v
    Origin Access Control (OAC)
      |
      v
    Private Amazon S3 Bucket

The website deployment pipeline is handled separately using GitHub
Actions:

    Local Development
          |
          v
    GitHub Repository
          |
          v
    GitHub Actions
          |
          | OIDC
          v
    AWS IAM Role
          |
          +-- S3 Sync
          |
          +-- CloudFront Invalidation

## AWS Resources Managed

Terraform currently manages:

-   Amazon S3 portfolio bucket
-   S3 Block Public Access configuration
-   S3 bucket policy
-   CloudFront Origin Access Control (OAC)
-   CloudFront distribution
-   Route 53 A alias record
-   Route 53 AAAA alias record
-   ACM TLS certificate
-   AWS WAF Web ACL
-   AWS managed WAF rule groups

The WAF configuration includes:

-   AWSManagedRulesAmazonIpReputationList
-   AWSManagedRulesCommonRuleSet
-   AWSManagedRulesKnownBadInputsRuleSet

## Terraform File Structure

    terraform/
    ├── providers.tf
    ├── data.tf
    ├── s3.tf
    ├── cloudfront.tf
    ├── route53.tf
    ├── acm.tf
    ├── waf.tf
    ├── outputs.tf
    └── .terraform.lock.hcl

### providers.tf

Defines the AWS providers.

The main infrastructure uses `eu-west-2` (Europe/London).

A second aliased provider is configured for `us-east-1` (US East/N.
Virginia). This is required because CloudFront ACM certificates and
CloudFront-scoped AWS WAF resources are managed in `us-east-1`.

### s3.tf

Contains the S3 portfolio bucket, Public Access Block configuration and
S3 bucket policy allowing CloudFront access. The S3 bucket remains
private and is not directly accessible from the internet.

### cloudfront.tf

Contains the CloudFront Origin Access Control, CloudFront distribution,
HTTPS redirection, IPv6 support, cache configuration, ACM certificate
association and AWS WAF association.

### route53.tf

Contains the DNS records for `aws.waygood.net`.

Both IPv4 and IPv6 are supported using Route 53 A and AAAA alias records
pointing to CloudFront.

### acm.tf

Manages the ACM TLS certificate used by CloudFront for
`aws.waygood.net`. The certificate uses DNS validation.

### waf.tf

Defines the AWS WAF Web ACL associated with CloudFront. AWS-managed rule
groups provide protection against common web attacks, malicious IP
addresses and known bad request patterns.

### outputs.tf

Provides useful Terraform outputs including:

-   `website_url`
-   `cloudfront_domain_name`
-   `s3_bucket_name`

## Authentication

Terraform authenticates to AWS using **AWS IAM Identity Center** rather
than permanent AWS access keys.

The local AWS CLI profile is:

    aws-portfolio

Login is performed using:

    aws sso login --profile aws-portfolio

The AWS provider then uses the temporary SSO credentials associated with
this profile. This avoids storing long-lived AWS access keys on the
local machine or inside the Git repository.

## Importing Existing Infrastructure

The AWS infrastructure was originally created manually.

Rather than destroying and recreating production resources, each
resource was defined in Terraform and imported into Terraform state.

Example:

    terraform import aws_s3_bucket.portfolio gareth-waygood-aws-portfolio

The workflow used for each resource was:

    Inspect existing AWS resource
              |
              v
    Write matching Terraform configuration
              |
              v
    terraform validate
              |
              v
    terraform import
              |
              v
    terraform plan
              |
              v
    Confirm no infrastructure changes

This allowed the live AWS environment to be transitioned safely to
Infrastructure as Code.

## Terraform Workflow

Initialize the working directory:

    terraform init

Format Terraform files:

    terraform fmt

Validate configuration:

    terraform validate

Preview infrastructure changes:

    terraform plan

Apply approved changes:

    terraform apply

Normal workflow:

    Edit Terraform
         |
         v
    terraform fmt
         |
         v
    terraform validate
         |
         v
    terraform plan
         |
         v
    Review carefully
         |
         v
    terraform apply

## Terraform State

Terraform state is currently stored locally for this portfolio project.

The following files/directories should be excluded from Git:

    .terraform/
    terraform.tfstate
    terraform.tfstate.*
    *.tfplan

Terraform state must not be committed to a public Git repository because
it may contain sensitive infrastructure information.

The provider lock file `.terraform.lock.hcl` should be committed to
ensure consistent provider versions.

## Security Design

### Private S3 Origin

Amazon S3 Block Public Access is enabled. Website files can only be
retrieved through CloudFront using Origin Access Control.

### HTTPS

CloudFront uses an ACM certificate for `aws.waygood.net`. HTTP requests
are redirected to HTTPS.

### AWS WAF

AWS WAF protects the CloudFront distribution using AWS-managed security
rule groups.

### Keyless GitHub Deployment

GitHub Actions authenticates to AWS using OpenID Connect (OIDC). No
permanent AWS access keys are stored in GitHub.

### Local Terraform Authentication

Local Terraform access uses AWS IAM Identity Center and temporary SSO
credentials instead of long-lived IAM access keys.

## Infrastructure Drift

Terraform can compare the code in this repository with the live AWS
environment.

A clean Terraform plan currently returns:

    No changes. Your infrastructure matches the configuration.

This provides a method of detecting infrastructure drift if resources
are later changed manually in the AWS Console.

## Skills Demonstrated

-   Terraform
-   Infrastructure as Code
-   Terraform state and resource imports
-   AWS IAM Identity Center
-   AWS CLI
-   Amazon S3
-   Amazon CloudFront
-   CloudFront Origin Access Control
-   Amazon Route 53
-   AWS Certificate Manager
-   AWS WAF
-   IPv4 / IPv6 dual-stack DNS
-   HTTPS / TLS
-   Git and GitHub
-   GitHub Actions
-   CI/CD
-   OpenID Connect
-   AWS IAM
-   Least-privilege access

## Project Status

The live AWS infrastructure has been successfully imported into
Terraform.

Current Terraform plan status:

    No changes. Your infrastructure matches the configuration.

Future work may include:

-   Remote Terraform state
-   State locking
-   Terraform CI validation through GitHub Actions
-   Replacing remaining hard-coded identifiers with variables/data
    sources
-   Reusable Terraform modules
-   Additional AWS portfolio projects focused on networking and
    infrastructure
