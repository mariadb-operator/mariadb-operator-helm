#!/bin/bash

set -euo pipefail

normalize_version() {
    local version="$1"
    IFS='.' read -r major minor patch <<< "$version"

    # Remove leading zeroes safely by using arithmetic expansion
    major=$((10#$major))
    minor=$((10#$minor))
    patch=$((10#$patch))

    echo "$major.$minor.$patch"
}

INPUT_VERSION=$1
VERSION=$(normalize_version "$INPUT_VERSION")

echo "📦 Input version: '$INPUT_VERSION'"
echo "📦 Normalized to semver-compliant version: '$VERSION'"

echo "📦 Bumping bundle to version '$VERSION'"

echo "📦 Updating Makefile"
sed -i "s/VERSION ?= .*/VERSION ?= $VERSION/g" Makefile
sed -i "s/HELM_VERSION ?= .*/HELM_VERSION ?= $INPUT_VERSION/g" Makefile

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