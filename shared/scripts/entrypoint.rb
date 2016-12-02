#!/usr/bin/env ruby

config = load("/shared/config.rb")

`/etc/init.d/redis-server restart` if config[:redis]
load "/shared/scripts/setup_mysql" if config[:mysql]
load "/shared/scripts/setup_postgres" if config[:postgres]

load "/shared/scripts/clone_and_deploy"

# Keep the container alive over the SSH daemon
`/usr/sbin/sshd -D`
