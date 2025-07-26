#!/bin/bash

set -euo pipefail

VERSION=$1

echo "📦 Bumping bundle to version '$VERSION'"

echo "📦 Updating Makefile"
sed -i "s/VERSION ?= .*/VERSION ?= $VERSION/g" Makefile

echo "📦 Generating bundle"
make bundle

echo "📦 Pushing changes"
git config user.email "martin11lrx@gmail.com"
git config user.name "Martin Montes"
git add .
git commit -m "Bump bundle to version '$VERSION'"
git push

echo "📦 Creating tag"
git tag $VERSION
git push --tags