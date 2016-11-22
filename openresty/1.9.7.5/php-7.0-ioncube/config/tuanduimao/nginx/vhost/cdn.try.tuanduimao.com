server {
    listen 80;
    server_name  cdn.try.tuanduimao.com;
    resolver 223.5.5.5 223.6.6.6 1.2.4.8 114.114.114.114 valid=3600s;
    root /data/stor/public;
    access_log  /logs/nginx/cdn.access.ui.log;
    error_log  /logs/nginx/cdn.error.ui.log;
    client_max_body_size 256m;
    index index.html;
}
