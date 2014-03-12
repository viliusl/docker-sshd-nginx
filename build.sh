#!/bin/sh -e
#
# Helper script for building docker image.

sudo docker build -rm=true -t=viliusl/ubuntu-sshd-nginx .