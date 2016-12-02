# docker-rails

*** WORK IN PROGRESS ***

An all-in-one Docker image which should fit many Rails apps.

- MySQL
- Postgres
- SQLite
- Redis
- Capistrano
- SSH access

## Build the image

```bash
docker build -t rails-server image/
```

## Configure your application

First copy the hole example dir and rename the example files:
```
cp -r shared shared-myapp
mv shared-myapp/config.example.rb shared-myapp/config.rb
```

Edit the `config.rb` to fit your needs.

## Create and start the container

```bash
docker run -d --restart=always -v /home/user/myapp/shared-myapp:/shared --name myapp rails-server
```

If you want to container to be accessible like a normal web server:

```bash
docker run -d --restart=always --publish 3000:3000 -v /home/user/myapp/shared-myapp:/shared --name myapp rails-server
```
