#!/bin/bash

set -euo pipefail

HELM_CHART_VERSION=$1
HELM_CHART_DIR="helm-charts/mariadb-operator"
RELEASE_URL="https://github.com/mmontes11/mariadb-operator/releases/download/helm-chart-$HELM_CHART_VERSION/mariadb-operator-$HELM_CHART_VERSION.tgz"

echo "Syncing helm chart version $HELM_CHART_VERSION";
if [ -d "$HELM_CHART_DIR" ]; then
  rm -rf $HELM_CHART_DIR
fi
curl -sL $RELEASE_URL | tar xz -C helm-charts/

echo "Syncing CRDs";
cp helm-charts/mariadb-operator/crds/crds.yaml config/manifests/crds/crds.yaml