# OIDC deployment

This example shows how to create a dbnl deployment on AWS (EKS) using OIDC for authentication.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Prerequisites

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured
- An [ACM certificate](https://console.aws.amazon.com/acm/home) for the domain you plan to deploy dbnl to
- An OIDC provider configured with a client application

## Required variables

| Variable | Description |
|---|---|
| `domain` | Domain to deploy dbnl to |
| `oidc_issuer` | OIDC issuer URL |
| `oidc_client_id` | OIDC client ID |
| `oidc_audience` | OIDC audience |
| `oidc_scopes` | OIDC scopes (default: `openid profile email`) |

Note: the AWS region is hardcoded to `us-east-1` in this example.

## Usage

1. Run `terraform apply` with your variables:

    ```bash
    AWS_PROFILE={AWS_PROFILE} terraform apply -var-file={TF_VARS_FILE}
    ```

2. Configure `kubectl` to connect to the cluster:

    ```bash
    aws eks update-kubeconfig --region us-east-1 --name $(terraform output -raw cluster_name)
    ```

3. Get the ALB hostname and create a CNAME record in your DNS provider pointing your domain to it:

    ```bash
    kubectl get ingress -A -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'
    ```
