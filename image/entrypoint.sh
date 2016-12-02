#!/bin/sh

echo Starting container
ruby /shared/scripts/entrypoint.sh > /shared/log/last_startup

echo Starting SSH daemon
/usr/sbin/sshd -D
