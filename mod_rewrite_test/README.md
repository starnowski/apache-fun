
[![Test for mod_rewrite option](https://github.com/starnowski/apache-fun/actions/workflows/mod_rewrite_test.yml/badge.svg)](https://github.com/starnowski/apache-fun/actions/workflows/mod_rewrite_test.yml)


Uncomment line 

```properties
LoadModule rewrite_module modules/mod_rewrite.so
```

Add virtual host:

```properties
<VirtualHost *:80>
  # MOD_REWRITE_TESTS
  RewriteEngine On
  RewriteRule   "^/show/my/staff/(.*)$"  "XXX_ANOTHER_SERVER_PROTOCOL://XXX_ANOTHER_HOST_IP_XXX:XXX_ANOTHER_SERVER_PORT/internal/$1" [R,L]
</VirtualHost>

```

The options :
-   XXX_ANOTHER_SERVER_PROTOCOL
-   XXX_ANOTHER_HOST_IP_XXX
-   XXX_ANOTHER_SERVER_PORT

should be replace by the "sed" statement __(check file [build_and_run_http_image.sh](./build_and_run_http_image.sh) script)__


## Links:
-   https://httpd.apache.org/docs/2.4/rewrite/proxy.html
-   https://hub.docker.com/_/httpd
