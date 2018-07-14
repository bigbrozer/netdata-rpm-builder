ARG RELEASE=7

FROM centos:${RELEASE}

LABEL authors="Vincent 'bigbrozer' BESANCON <besancon.vincent@gmail.com>"
LABEL package_name='netdata'
LABEL package_sources='https://github.com/firehol/netdata'

RUN set -ex \
        && mkdir -p /build/dist /build/patches /build/src

RUN set -ex \
        && yum -y install \
                rpm-build \
                redhat-rpm-config \
                yum-utils \
                autoconf \
                automake \
                curl \
                gcc \
                git \
                libmnl-devel \
                libuuid-devel \
                make \
                pkgconfig \
                zlib-devel

COPY patches/* /build/patches
COPY build-netdata.sh /build

CMD ["/build/build-netdata.sh"]
