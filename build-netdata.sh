#!/bin/bash
#
set -eu

PATH=/usr/bin

# Clone netdata sources
get_sources() {
    local rc

    git clone https://github.com/firehol/netdata.git /build/src/netdata
    
    rc=$?
    if [[ $rc == 0 ]]
    then
        echo "Fetching sources is complete. Done."
    else
        echo "Fetching sources has failed. Error."
    fi

    return $rc
}

# Apply patches for building netdata
apply_patches() {
    (cd /build/src/netdata && patch -p0 < /build/patches/*.patch)
}

# Start build process
build() {
    local rc

    /build/src/netdata/contrib/rhel/build-netdata-rpm.sh

    rc=$?
    if [[ $rc == 0 ]]
    then
        echo "Build is complete. Done."
    else
        echo "Build has failed. Error."
    fi

    return $rc
}

dist() {
    local rc

    find /root/rpmbuild -name '*.rpm' -exec cp {} /build/dist \;

    rc=$?
    if [[ $rc == 0 ]]
    then
        echo "RPMs copied to /dist. Done."
    else
        echo "Failed to copy RPMs to /dist. Error."
    fi

    return $rc
}

# MAIN
main() {
    get_sources \
        && apply_patches \
        && build \
        && dist

    exit $?
}

main
