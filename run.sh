#!/bin/sh -e
#
# Helper script for running image with proper port mappings.

sudo docker run -d -p 55522:22 -p 55580:80 viliusl/ubuntu-sshd-nginx