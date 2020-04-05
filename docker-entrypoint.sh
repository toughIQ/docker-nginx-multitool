#!/bin/bash
set -e

DEFAULT_CONFIG=/etc/nginx/conf.d/default.conf

# remove default config if exists (its already gone if container is restarted)
if [ -f $DEFAULT_CONFIG ]; then
rm -f /etc/nginx/conf.d/default.conf
fi

# copy append_nginx_http template to add directices to nginx.conf http section
cp -f /etc/nginx/templates/append_nginx_http.template /etc/nginx/conf.d/append_nginx_http.conf

# copy template according to CONFIG_TYPE setting to conf.d
cp -f /etc/nginx/templates/$CONFIG_TYPE.template /etc/nginx/conf.d/$CONFIG_TYPE.conf

ENVS=(`env|grep NGX_`)
# iterate through variables array
for envvar in "${ENVS[@]}"; do
    # split each VAR line into name and value
    var_name=${envvar%=*}
    var_value=${envvar#*=}

    # substitute variable name with corresponding value in config file
    sed -i "s/$var_name/$var_value/g" /etc/nginx/conf.d/$CONFIG_TYPE.conf
done

exec "$@"
