FROM opensuse/leap:15.2
LABEL description="Running a bzflag server in a docker container"
MAINTAINER Mathias.Homann@opensuse.org

## create a user and group
RUN useradd \
        -c "The user that runs the BZFlag server" \
        --no-log-init \
        -m \
        -U \
        bzfs

## build date: 2021-03-24
RUN zypper addrepo -r https://download.opensuse.org/repositories/games/openSUSE_Leap_15.2/games.repo
RUN zypper clean --all

RUN zypper --gpg-auto-import-keys refresh
RUN zypper patch -y -l --with-optional ; exit 0
RUN zypper patch -y -l --with-optional ; exit 0

RUN zypper install -y -l bzflag

RUN zypper clean --all

ADD bzfs.conf /var/bzfs/
ADD vars.txt /var/bzfs/
ADD map.bzw /var/bzfs/

EXPOSE 5154 5154/udp

WORKDIR /home/bzfs
USER bzfs
ENTRYPOINT ["/usr/bin/bzfs","-conf"]
CMD        ["/var/bzfs/bzfs.conf"]
