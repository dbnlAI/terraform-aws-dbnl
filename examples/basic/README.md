# Basic deployment

This example shows how to create a basic dbnl deployment to get familiar with the infrastructure and app.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Usage

1. Create an [ACM certificate](https://console.aws.amazon.com/acm/home) for the domain you plan to deploy dbnl.

2. Run `terraform apply` specifying your admin password, domain and registry credentials.

    AWS_PROFILE={AWS_PROFILE} terraform apply -var-file={TF_VARS_FILE}

3. Update your DNS registry with a CNAME record pointing your domain to the dbnl [load balancer](https://console.aws.amazon.com/ec2/home#LoadBalancers:).
