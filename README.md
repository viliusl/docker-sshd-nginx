docker-sshd-nginx
=================

Dockerfile for building docker container with passwordless sshd server and nginx serving static page. This is mostly a template for some possibly useful image.

## About

This repository contains all needed resources to build a docker image with following features:
* sshd with passwordless login;
* nginx running and serving simple static page.
* services configured and runnign via supervisor.

For convenience there is a *./manage.sh* command for building, starting (with proper port mappings), stopping and connecting via ssh.

## Usage

You can download [this image](https://index.docker.io/u/viliusl/ubuntu-sshd-nginx/) from public [Docker Registry](https://index.docker.io/).

**Run using command:**
```
docker run -d -p 55522:22 -p 55580:80 viliusl/ubuntu-sshd-nginx
```

**Connect via ssh:**
```
ssh root@localhost -p 55522
```

Just don't forget to add private key (yeah, I know) from **ssh_keys** folder to you '~/.ssh/' and add it via 'ssh-add'

Happy cooking.
