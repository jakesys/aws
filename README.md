# jakesys/aws

# *** MOVED TO GITLAB ***

Small, simple Alpine Linux based Docker container for AWS CLI.

Based on the official `alpine:latest` image and the latest `aws` CLI via `pip`.

https://gitlab.com/jakesys/aws is the authoritative repository for this project; its CI/CD pipeline is triggered daily to build, test, and push the most recent AWS CLI version to `jakesys/aws` on [Docker Hub](https://hub.docker.com/r/jakesys/aws).

## Usage
```
docker run <docker-opts> -v <local-aws-config>:/root/.aws jakesys/aws [--log] [<opts>] <subcmd> ...
```
### Extra Options

#### `--log`
Outputs log entries on STDERR, which start with a timestamp and the container's `hostname`.  Useful when using the 'awslog' logging driver and you prefer not to have *every* line of output be its own CloudWatch log entry.  You'll need to use the `awslogs-datetime-format='%FT%TZ - '` awslog log option to get CloudWatch to parse log entries properly.

* START log entry contains the `aws` commandline being executed.
* OUTPUT log entry contains the interleaved STDOUT and STDERR from the executed commandline.
* EXIT log entry contains the commandline's exit code and duration, in seconds.
