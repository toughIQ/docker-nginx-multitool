[![build status](https://git.apa.at/docker/nginx-multitool/badges/master/build.svg)](https://git.apa.at/docker/nginx-multitool/commits/master)

# Enhanced NginX

This image is based on the standard __NginX__:stable Docker image.
It adds basic configuration options via Environment variables.

Current Templates:
- Simple_Proxy: simple HTTP Proxy
- SSL_Proxy: SSL off-loading and 80 to 443 rewriting
- HTTP2HTTPS: Rewrites all Requests on Listen Port (Default 80) to HTTPS
- Redirect: Redirects all incoming to NGX_REDIRECT_DESTINATION

