# lampdev
php 7.4 with xdebug, MySQL, Apache on Ubuntu docker image

# Example
```docker
FROM jatheepan/lampdev:0.0.1

WORKDIR /var/www/html
COPY ./app /var/www/html

ENV XDEBUG_CONFIG="idekey=YOURSECRETKEY remote_host=docker.for.mac.host.internal default_enable=0 remote_enable=1 remote_autostart=0 remote_connect_back=0 profiler_enable=0"
```
