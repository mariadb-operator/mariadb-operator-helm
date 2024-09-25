#!/bin/bash

set -euo pipefail

install_yq() {
  if ! command -v yq &> /dev/null; then
    echo "yq command not found, installing yq..."
    sudo curl -sSLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.43.1/yq_linux_amd64
    sudo chmod +x /usr/local/bin/yq
  fi
}
install_yq

HELM_CHART_VERSION=$1
HELM_CHART_DIR="helm-charts/mariadb-operator"
HELM_CHART_FILE="$HELM_CHART_DIR/Chart.yaml"
RELEASE_URL="https://github.com/mariadb-operator/mariadb-operator/releases/download/mariadb-operator-$HELM_CHART_VERSION/mariadb-operator-$HELM_CHART_VERSION.tgz"

echo "☸️  Syncing helm chart version $HELM_CHART_VERSION";
if [ -d "$HELM_CHART_DIR" ]; then
  rm -rf $HELM_CHART_DIR
fi
curl -sL $RELEASE_URL | tar xz -C helm-charts/

HELM_CRDS_VERSION=$(yq e '.dependencies[] | select(.name == "mariadb-operator-crds").version' $HELM_CHART_FILE)

echo "☸️  Unpacking CRDs version $HELM_CRDS_VERSION";
tar xz -f "helm-charts/mariadb-operator/charts/mariadb-operator-crds-$HELM_CRDS_VERSION.tgz" -C "helm-charts/"

echo "☸️  Syncing CRDs";
cp helm-charts/mariadb-operator-crds/templates/crds.yaml config/manifests/crds/crds.yaml