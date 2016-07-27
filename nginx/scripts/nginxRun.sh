#!/bin/sh
exec /usr/local/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -g "daemon off;"
