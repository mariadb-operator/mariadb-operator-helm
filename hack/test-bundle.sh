#!/bin/bash

set -euo pipefail

VERSION=$1

if [ -z $VERSION ]; then 
  echo "Version is mandatory. Usage: test-bunde.sh <version>"
  exit 1
fi

REPO="https://github.com/k8s-operatorhub/community-operators"
COMMUNITY_DIR=$(basename $REPO)
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT="$SCRIPT_DIR/../"
BUNDLE_DIR="$REPO_ROOT/bundle"
OPERATOR_DIR="operators/mariadb-operator/$VERSION"

echo "📦 Cloning community-operators repo"
if [ ! -d $COMMUNITY_DIR ]; then
  git clone $REPO 
fi

cd $COMMUNITY_DIR
git pull
echo "📦 Copying bundle"
rm -rf $OPERATOR_DIR
mkdir -p $OPERATOR_DIR
cp -Tr $BUNDLE_DIR $OPERATOR_DIR
echo "📦 Running tests"
bash <(curl -sL https://raw.githubusercontent.com/redhat-openshift-ecosystem/community-operators-pipeline/ci/latest/ci/scripts/opp.sh) \
  kiwi,lemon,orange \
  "$OPERATOR_DIR"
cd -