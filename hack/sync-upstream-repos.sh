#!/bin/bash

set -euo pipefail

VERSION=$1

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT="$SCRIPT_DIR/../"
BUNDLE_DIR="$REPO_ROOT/bundle"

COMMUNITY_REPO="git@github.com:mmontes11/community-operators.git"
COMMUNITY_REPO_NAME="community-operators"
COMMUNITY_UPSTREAM_REPO="git@github.com:k8s-operatorhub/community-operators.git"
COMMUNITY_UPSTREAM_NAME="k8s-operatorhub/community-operators"

OPENSHIFT_REPO="git@github.com:mmontes11/community-operators-prod.git"
OPENSHIFT_REPO_NAME="community-operators-prod"
OPENSHIFT_UPSTREAM_REPO="git@github.com:redhat-openshift-ecosystem/community-operators-prod.git"
OPENSHIFT_UPSTREAM_NAME="redhat-openshift-ecosystem/community-operators-prod"

function sync_repo() {
  REPO=$1
  NAME=$2
  UPSTREAM_REPO=$3
  UPSTREAM_NAME=$4
  echo "🚀 Syncing repo '$NAME' with upstream '$UPSTREAM_NAME'"

  echo "🚀 Setting up repo"
  if [ -d "$NAME" ]; then
    rm -rf $NAME
  fi
  git clone $REPO $NAME
  cd $NAME
  git remote add upstream $UPSTREAM_REPO
  git fetch --all
  git reset --hard upstream/main

  echo "🚀 Copying bundle"
  mkdir -p operators/mariadb-operator/$VERSION
  cp -Tr $BUNDLE_DIR operators/mariadb-operator/$VERSION
  
  echo "🚀 Submitting PR"
  git add .
  git commit -m "operator mariadb-operator ($VERSION)" --signoff
  git push
  gh pr create --repo $UPSTREAM_REPO \
    --title "operator mariadb-operator ($VERSION)" \
    --body "Add operator mariadb-operator ($VERSION) to community operators"
  cd -
}

git config --global user.mail "martin11lrx@gmail.com"
git config --global user.name "Martin Montes"

sync_repo $COMMUNITY_REPO $COMMUNITY_REPO_NAME $COMMUNITY_UPSTREAM_REPO $COMMUNITY_UPSTREAM_NAME
sync_repo $OPENSHIFT_REPO $OPENSHIFT_REPO_NAME $OPENSHIFT_UPSTREAM_REPO $OPENSHIFT_UPSTREAM_NAME