AWS Cloud Portfolio

A practical AWS portfolio demonstrating cloud architecture, networking, security, content delivery and automation.

This repository contains hands-on AWS projects designed to show real-world infrastructure skills rather than just certification knowledge.

Project 1 — Secure Static Website Hosting

A static portfolio website hosted on AWS using a secure and globally distributed architecture.

Architecture

User
  ↓
Route 53
  ↓
CloudFront
  ↓
Origin Access Control
  ↓
Private S3 Bucket

AWS Services Used

* Amazon S3
* Amazon CloudFront
* Amazon Route 53
* AWS Certificate Manager
* CloudFront Origin Access Control

Key Features

* HTTPS encryption using an ACM certificate
* CloudFront global content delivery
* Private S3 bucket
* CloudFront-only access to website content
* Custom DNS using Route 53
* CloudFront cache invalidation for deployments

Security

The S3 bucket is not publicly accessible.

CloudFront uses Origin Access Control to securely retrieve content from S3, allowing the website to remain publicly available while the underlying storage stays private.

What I Learned

This project provided practical experience with:

* DNS configuration
* TLS certificates
* CloudFront distributions
* S3 permissions
* Origin Access Control
* Content caching
* Cache invalidation
* AWS service integration

Upcoming Projects

Planned additions include:

* Highly available multi-AZ VPC architecture
* Application Load Balancer
* Auto Scaling
* Private and public subnets
* NAT Gateway
* RDS Multi-AZ
* AWS Transit Gateway
* Site-to-Site VPN
* Infrastructure as Code
* CI/CD deployment with GitHub Actions

Repository Structure

aws-portfolio/
├── README.md
├── index.html
├── project1.html
├── css/
├── images/
└── docs/

Portfolio Website

Live AWS portfolio website:

https://aws.waygood.net
