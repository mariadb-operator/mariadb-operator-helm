#!/bin/bash

set -euo pipefail

COMMUNITY_REPO="git@github.com:mmontes11/community-operators.git"
COMMUNITY_REPO_NAME="community-operators"

OPENSHIFT_REPO="git@github.com:mmontes11/community-operators-prod.git"
OPENSHIFT_REPO_NAME="community-operators-prod"

function clone_repo() {
  REPO=$1
  NAME=$2

  if [ -d $NAME ]; then
    rm -rf $NAME
  fi
  git clone $REPO $NAME
}

clone_repo $COMMUNITY_REPO $COMMUNITY_REPO_NAME
clone_repo $OPENSHIFT_REPO $OPENSHIFT_REPO_NAME