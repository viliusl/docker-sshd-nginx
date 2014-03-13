FROM ubuntu:precise

MAINTAINER Vilius Lukosius <vilius.lukosius@gmail.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# install sshd, nginx and supervisor
RUN apt-get install -y openssh-server supervisor nginx

# configure supervisor
RUN mkdir -p /var/log/supervisor

# configure sshd with passwordless auth
RUN mkdir -p /var/run/sshd
ADD ssh_keys/id_rsa_docker.pub /tmp/id_rsa_docker.pub
RUN mkdir -p /root/.ssh
RUN cat /tmp/id_rsa_docker.pub >> /root/.ssh/authorized_keys
RUN rm /tmp/id_rsa_docker.pub

# configure nginx to serve static page
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir -p /var/www
ADD nginx/include.d         /etc/nginx/include.d
ADD nginx/default           /etc/nginx/sites-available/default
ADD nginx/index.html        /var/www/index.html

# configure supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisor/sshd.conf   /etc/supervisor/conf.d/sshd.conf
ADD supervisor/nginx.conf   /etc/supervisor/conf.d/nginx.conf

#clean-up
RUN apt-get clean

expose 22
expose 80

CMD ["/usr/bin/supervisord", "-n"]