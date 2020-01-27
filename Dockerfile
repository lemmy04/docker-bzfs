FROM opensuse/leap:15.1
LABEL description="Running a bzflag server in a docker container"
MAINTAINER Mathias.Homann@opensuse.org

## create a user and group
RUN useradd \
        -c "The user that runs the BZFlag server" \
        --no-log-init \
        -m \
        -U \
        bzfs

RUN zypper addrepo -r https://download.opensuse.org/repositories/home:/lemmy04/openSUSE_Leap_15.1/home:lemmy04.repo
RUN zypper clean --all

RUN zypper --gpg-auto-import-keys refresh
RUN zypper patch -y -l --with-optional ; exit 0
RUN zypper patch -y -l --with-optional ; exit 0

RUN zypper install -y -l bzflag

ADD bzfs.conf /var/bzfs/
ADD vars.txt /var/bzfs/
ADD map.bzw /var/bzfs/

EXPOSE 5154 5154/udp

WORKDIR /home/bzfs
USER bzfs
CMD ["/usr/bin/bzfs","-conf","/var/bzfs/bzfs.conf"]
