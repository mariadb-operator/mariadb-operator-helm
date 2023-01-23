#!/bin/bash

REPO="https://github.com/mmontes11/mariadb-operator"
HELM_CHART_PATH="helm-charts/mariadb-operator"
HELM_CHART_VERSION="${1}"

EXISTS=$(grep -ir ${HELM_CHART_VERSION} ${HELM_CHART_PATH}/Chart.yaml | wc -l)

if [ ${EXISTS} -ge 1 ]; then
  echo "Helm chart version ${HELM_CHART_PATH} already synced, skipping";
else 
  echo "Helm chart version ${HELM_CHART_PATH} does not exist, syncing";
  rm -rf ${HELM_CHART_PATH}/*
  curl -sL ${REPO}/releases/download/helm-chart-${HELM_CHART_VERSION}/mariadb-operator-${HELM_CHART_VERSION}.tgz | tar xz -C helm-charts/
fi