#!/bin/bash
#
set -eu -o pipefail

PATH=/usr/bin

# Clone netdata sources
get_sources() {
    local latest_release
    local rc

    # Get latest stable release
    latest_release=$(curl -sSL \
        https://api.github.com/repos/netdata/netdata/releases/latest \
        | jq -r '.tag_name')

    git clone \
        --depth 1 \
        --branch "${latest_release}" \
        https://github.com/netdata/netdata.git \
        /build/src/netdata
    
    rc=$?
    if [[ $rc == 0 ]]
    then
        echo "Sources pointing to release ${latest_release}."
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
