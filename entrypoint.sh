#!/bin/sh

set -e

if [ -n "$NPM_AUTH_TOKEN" ]; then
  # Respect NPM_CONFIG_USERCONFIG if it is provided, default to $HOME/.npmrc
  NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG-"$HOME/.npmrc"}"
  NPM_REGISTRY_URL="${NPM_REGISTRY_URL-https://registry.npmjs.org}"
  NPM_REGISTRY_HOST=`echo $NPM_REGISTRY_URL | sed 's/https\?:\/\///'`

  # Allow registry.npmjs.org to be overridden with an environment variable
  printf "//$NPM_REGISTRY_HOST/:_authToken=$NPM_AUTH_TOKEN\nregistry=$NPM_REGISTRY_URL" > "$NPM_CONFIG_USERCONFIG"
  chmod 0600 "$NPM_CONFIG_USERCONFIG"
fi

sh -c "npm $*"
