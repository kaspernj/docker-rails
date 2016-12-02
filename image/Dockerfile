FROM ubuntu:16.04

# APT configuration
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y --force-yes apt-utils

# Install base packages
RUN apt-get install -y --force-yes openssh-server sudo nano cron redis-server

# Configure deploy user
RUN /usr/sbin/useradd -s /bin/bash -m deploy

RUN mkdir /home/deploy/.ssh
RUN chown -R deploy:deploy /home/deploy/.ssh
RUN ln -s /sharred/ssh/config /home/deploy/.ssh/config
RUN ln -s /shared/ssh/authorized_keys /home/deploy/.ssh/authorized_keys

RUN mkdir /var/run/sshd

# Set up allowed sudo commands
RUN ln -s /shared/deploy_sudo_access /etc/sudoers.d/90-deploy-user

# Install MySQL
RUN apt-get -y --force-yes install mysql-server
RUN rm -rf /usr/lib/mysql
RUN rm -rf /var/lib/mysql
RUN ln -s /shared/mysql/lib /usr/lib/mysql
RUN ln -s /shared/mysql/var /var/lib/mysql

# Install Postgres
RUN apt-get -y --force-yes install postgresql postgresql-contrib
RUN rm -rf /usr/lib/postgres
RUN rm -rf /var/lib/postgres
RUN ln -s /shared/postgres/usr /usr/lib/postgres
RUN ln -s /shared/postgres/var /var/lib/postgres

# Install Ruby
RUN apt-get install -y --force-yes ruby2.3 ruby2.3-dev git-core
RUN gem install bundler

# Build deps for the Ruby and various gems
RUN apt-get install -y --force-yes build-essential automake bison autoconf pkg-config \
  openssl libssl-dev zlib1g zlib1g-dev libyaml-dev git-core curl gawk g++ gcc make \
  libc6-dev libreadline6-dev libgdbm-dev libncurses5-dev libtool libffi-dev \
  libxslt-dev libxml2-dev libmysqlclient-dev libmagick++-dev imagemagick nodejs \
  libsqlite3-dev sqlite3 libpq-dev

# Initialize the project
RUN mkdir -p /var/www/app/shared/config /var/www/app/shared/public /var/www/app/shared/db
RUN ln -s /shared/app/config/database.yml /var/www/app/shared/config/database.yml
RUN ln -s /shared/app/config/secrets.yml /var/www/app/shared/config/secrets.yml
RUN ln -s /shared/app/public/system /var/www/app/shared/public/system
RUN ln -s /shared/app/log /var/www/app/shared/log
RUN ln -s /shared/sqlite/production.sqlite /var/www/app/shared/db/production.sqlite
RUN chown -R deploy:deploy /var/www/app

# Start SSH
ENTRYPOINT ["/shared/scripts/entrypoint.rb > /shared/log/last_startup"]
