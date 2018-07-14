# RPM builder for Netdata

This will build RPMs for [netdata](https://github.com/firehol/netdata).

## Build images

```shell
# For building image for RHEL 7 (default)
docker build -t bigbrozer/netdata-rpm-builder:7 .

# For building image for RHEL 6
docker build --build-arg RELEASE=6 -t bigbrozer/netdata-rpm-builder:6 .
```

## Build RPMs

Currently supported:

```shell
# Build RPMs for RHEL 7
./run.py -r 7

# Build RPMs for RHEL 6
./run.py -r 6
```

Manual builds:

```shell
# Build RPMs for RHEL 7
docker run \
    -t \
    --rm \
    -v $(pwd)/dist:/build/dist \
    bigbrozer/netdata-rpm-builder:7

# Build RPMs for RHEL 6
docker run \
    -t \
    --rm \
    -v $(pwd)/dist:/build/dist \
    bigbrozer/netdata-rpm-builder:6
```

Resulted RPMs are located into the `dist/` folder.
