provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  shared_credentials_file = "/Users/daveischad/.aws/credentials"
}

# Create a VPC
resource "aws_vpc" "tftestrunVPC" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_s3_bucket" "tftestrunB" {
  bucket = "bucket4myvalentine1"
}
 
resource "aws_instance" "tftestruneast1" {
  ami = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  depends_on = ["aws_s3_bucket.tftestrunB"] # Dependency to S3-Bucket
}
variable "env" {
  type = string
  default = "dev"
}
 
resource "aws_s3_bucket" "tftestrunB2" {
  bucket = "bucket4myvalentine1-${var.env}"
}
 
variable "bucket-prefix" {
  type = "map"
  default = {
    "dev" = "tmp-"
    "prod" = ""
  }
}
 
resource "aws_s3_bucket" "example" {
  bucket = "${lookup(var.bucket-prefix, var.env)}davechad-${var.env}"
} 