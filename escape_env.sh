#!/usr/bin/env bash

# Use to escape a configuration file so it can be sourced as environ
# on current shell. For example:
#
#     escape_env .env_wsgi && set -a && source .env_wsgi && unescape_env .env_wsgi
#

escape_env(){
    sed -i -re "s/=\[/='[/;s/\]$/]'/" $1
}

unescape_env(){
    sed -i -re "s/='\[/=[/;s/\]'$/]/" $1
}
