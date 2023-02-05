#!/bin/bash

set -euo pipefail

VERSION=$1

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT="$SCRIPT_DIR/../"
BUNDLE_DIR="$REPO_ROOT/bundle"

COMMUNITY_REPO="git@github.com:mmontes11/community-operators.git"
COMMUNITY_REPO_DIR="community-operators"
OPENSHIFT_REPO="git@github.com:mmontes11/community-operators-prod.git"
OPENSHIFT_REPO_DIR="community-operators-prod"

function sync_repo() {
  REPO=$1
  DIR=$2
  echo "Syncing repo '$REPO'"

  if [ -d "$DIR" ]; then
    rm -rf $DIR
  fi
  git clone $REPO $DIR
  mkdir -p operators/mariadb-operator/$VERSION
  cp -Tr $BUNDLE_DIR \
    $DIR/operators/mariadb-operator/$VERSION
  
  cd $DIR
  git add .
  git commit -am "operator mariadb-operator ($VERSION)" --signoff
  git push
  # TODO: git push
  # TODO: gh create pr
  cd -
}

git config --global user.mail "martin11lrx@gmail.com"
git config --global user.name "Martin Montes"

sync_repo $COMMUNITY_REPO $COMMUNITY_REPO_DIR
sync_repo $OPENSHIFT_REPO $OPENSHIFT_REPO_DIR