# RPM builder for Netdata

This will build RPMs for [netdata](https://github.com/netdata/netdata).

## Quick start

If you are only interested by the installation of netdata on your systems using RPM, follow this quick steps to setup the Yum/Dnf repository:

```shell
# For RHEL 7.x
$ cat <<'EOF' | sudo tee /etc/yum.repos.d/bigbrozer_netdata.repo
[bigbrozer_netdata]
name=bigbrozer_netdata
baseurl=https://packagecloud.io/bigbrozer/netdata/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/bigbrozer/netdata/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF

# For RHEL 6.x, the package is not yet available...
```

Update Yum/Dnf cache:

```shell
$ sudo yum makecache fast
$ sudo dnf makecache fast
```

Install package:

```shell
$ sudo yum install netdata
$ sudo dnf install netdata
```

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
