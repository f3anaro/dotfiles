# Nginx configuration files
au BufRead,BufNewFile /etc/nginx/conf/* set ft=nginx
au BufRead,BufNewFile conf/nginx/* set ft=nginx$uri