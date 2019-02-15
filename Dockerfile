FROM fedora:latest
MAINTAINER Mathias.Homann@opensuse.org

RUN dnf -y update && dnf clean all
RUN dnf -y install bzflag

mkdir -p /var/bzfs

EXPOSE 5154

CMD ["/bin/bzfs","-conf","/var/bzfs/bzfs.conf"]
