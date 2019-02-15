FROM opensuse/leap:15.0
LABEL description="Running a bzflag server in a docker container"
MAINTAINER Mathias.Homann@opensuse.org

RUN zypper install -y -l bzflag

ADD bzfs.conf /var/bzfs/
ADD vars.txt /var/bzfs/
ADD map.bzw /var/bzfs/

EXPOSE 5154 5154/udp

CMD ["/usr/bin/bzfs","-conf","/var/bzfs/bzfs.conf"]
