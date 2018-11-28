#!/bin/bash

# Debug, echo every command
#set -x

GATSBY_ENV_PREFIX="${GATSBY_ENV_PREFIX:-GATSBY_}"

# Each bundle is generated with a unique hash name to bust browser cache.
# Use shell `*` globbing to fuzzy match.
GATSBY_TARGET_BUNDLE="${GATSBY_TARGET_BUNDLE:-/app/build/index.*.js}"

if [ -f $GATSBY_TARGET_BUNDLE ]
then

  # Get exact filename.
  js_bundle_filename=`ls $GATSBY_TARGET_BUNDLE`
  
  echo "Injecting runtime env into $js_bundle_filename (from .profile.d/inject_js_runtime_env.sh)"

  # Render runtime env vars into bundle.
  ruby -E utf-8:utf-8 \
    -r /app/.heroku-js-runtime-env/injectable_env.rb \
    -e "InjectableEnv.replace('$js_bundle_filename')"
fi
