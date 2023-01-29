#!/bin/bash

set -euo pipefail

VERSION=$1
# TODO: trim left 'v' 

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT="$SCRIPT_DIR/../"
BUNDLE_DIR="$REPO_ROOT/bundle"

COMMUNITY_REPO="https://github.com/mmontes11/community-operators"
OPENSHIFT_REPO="https://github.com/mmontes11/community-operators-prod"

function sync_repo() {
  REPO=$1
  DIR=$(basename $REPO)
  echo "Syncing repo '$REPO'"

  if [ -d "$DIR" ]; then
    rm -rf $DIR
  fi
  git clone $REPO
  mkdir -p operators/mariadb-operator/$VERSION
  cp -Tr $BUNDLE_DIR \
    $DIR/operators/mariadb-operator/$VERSION
  
  cd $DIR
  git add .
  git commit -am "operator mariadb-operator ($VERSION)" --signoff
  # TODO: git push
  # TODO: gh create pr
  cd -
}

git config --global user.mail "martin11lrx@gmail.com"
git config --global user.name "Martin Montes"

sync_repo $COMMUNITY_REPO
sync_repo $OPENSHIFT_REPO