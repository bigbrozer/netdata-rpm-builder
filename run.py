#!/usr/bin/env python3

"""
Build netdata into a Docker container.

Resulted RPMs are available in dist/ folder.
"""

import argparse
import os.path
import subprocess


CURRENT_DIR = os.path.abspath(os.path.dirname(__file__))


def parse_args():
    parser = argparse.ArgumentParser(
        description='Build netdata RPM into a Docker container.')
    parser.add_argument('-r', '--el-release',
                        dest='release',
                        choices=['6', '7'],
                        required=True,
                        help='The RHEL release version.')

    return parser.parse_args()


def main():
    args = parse_args()

    try:
        subprocess.run([
            'docker', 'run',
            '-t',
            '--rm',
            '-v', '%s/dist:/build/dist' % CURRENT_DIR,
            'bigbrozer/netdata-rpm-builder:%s' % (args.release),
        ], check=True)
    except subprocess.CalledProcessError as e:
        print('\nUh, oh... something went wrong ! Looks above for errors.')
        print('\nError: %s' % e)


if __name__ == '__main__':
    main()
