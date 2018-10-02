# jakesys/aws

# *** MOVED TO GITLAB ***

Small, simple Alpine Linux based Docker container for AWS CLI.

Based on the official `alpine:latest` image and the latest `aws` CLI via `pip`.

https://gitlab.com/jakesys/aws is the authoritative repository for this project; its CI/CD pipeline is triggered daily to build, test, and push the most recent AWS CLI version to `jakesys/aws` on [Docker Hub](https://hub.docker.com/r/jakesys/aws).

## Usage
```
docker run <docker-opts> -v <local-aws-config>:/root/.aws jakesys/aws <subcommand> ...
```
