server {
    listen 80;
    server_name try.tuanduimao.com;
    resolver 223.5.5.5 223.6.6.6 1.2.4.8 114.114.114.114 valid=3600s;
    root /code/tuanduimao;
    access_log  /logs/nginx/access.tuanduimao.log;
    error_log  /logs/nginx/error.tuanduimao.log;
    
    location / {
	   include /code/tuanduimao/api.route.rewrite.conf;
    }

    client_max_body_size 256m;
    index index.php;
    location ~ \.php$ {
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass unix:/run/php/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_split_path_info ^(.+\.php)(.*)$;
        include fastcgi_params;
        try_files $uri =404;
	} 
}

