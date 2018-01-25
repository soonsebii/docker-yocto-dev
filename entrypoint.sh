#!/bin/bash

DEBUG="${DEBUG:-false}"
[[ "$DEBUG" == true ]] && set -x

#
# git
#
GIT_CONFIG_NAME="${GIT_CONFIG_NAME:-builder}"
GIT_CONFIG_EMAIL="${GIT_CONFIG_EMAIL:-builder@workhard.com}"

git config --global user.name "$GIT_CONFIG_NAME"
git config --global user.email "$GIT_CONFIG_EMAIL"
git config --global color.ui false

#
# repo
#
REPO_ENABLED="${REPO_ENABLED:-false}"
REPO_TRACE="${REPO_TRACE:-false}"
REPO_INIT_MANIFEST_URL="${REPO_INIT_MANIFEST_URL:-}"
REPO_INIT_MANIFEST_BRANCH="${REPO_INIT_MANIFEST_BRANCH:-}"
REPO_INIT_OPTIONS="${REPO_INIT_OPTIONS:-}"
REPO_SYNC_JOBS="${REPO_SYNC_JOBS:-4}"
REPO_SYNC_OPTIONS="${REPO_SYNC_OPTIONS:-}"

if [ "$REPO_ENABLED" = true ]; then
  mkdir -p "${WORKDIR}/yocto/source" && cd "${WORKDIR}/yocto/source"

  [[ "$REPO_TRACE" == true ]] && REPO_OPTION="--trace" || REPO_OPTION=""

  INIT_OPTION="-u $REPO_INIT_MANIFEST_URL"
  [[ -n "$REPO_INIT_MANIFEST_BRANCH" ]] && INIT_OPTION+=" -b $REPO_INIT_MANIFEST_BRANCH"
  [[ -n "$REPO_INIT_OPTIONS" ]] && INIT_OPTION+=" $REPO_INIT_OPTIONS"
  [[ "$DEBUG" == false ]] && INIT_OPTION+=" -q"

  SYNC_OPTION="-j $REPO_SYNC_JOBS"
  [[ -n "$REPO_SYNC_OPTIONS" ]] && SYNC_OPTION+=" $REPO_SYNC_OPTIONS"
  [[ "$DEBUG" == false ]] && SYNC_OPTION+=" -q"
  
  repo $REPO_OPTION init $INIT_OPTION
  repo $REPO_OPTION sync $SYNC_OPTION
fi

if [ "$1" == "-d" ]; then
  while true; do sleep 1000; done
else
  exec "$@"
fi
