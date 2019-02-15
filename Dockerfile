FROM fedora:latest
MAINTAINER Mathias.Homann@opensuse.org

RUN dnf -y update && dnf clean all
RUN dnf -y install bzflag

ADD bzfs.conf /var/bzfs/
ADD vars.txt /var/bzfs/
ADD map.bzw /var/bzfs/

EXPOSE 5154 5154/udp

CMD ["/bin/bzfs","-conf","/var/bzfs/bzfs.conf"]
