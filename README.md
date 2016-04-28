# jakesys/aws

Small, simple Alpine Linux-based Docker container for AWS CLI.

Based on the official `alpine:latest` image and the latest `aws` CLI via `pip`.

## Usage
```
docker run <docker-opts> -v <local-aws-config>:/root/.aws jakesys/aws <subcommand> ...
```
