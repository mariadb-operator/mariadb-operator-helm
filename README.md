<p align="center">
<img src="https://mariadb-operator.github.io/mariadb-operator/assets/mariadb_centered_whitebg.svg" alt="mariadb" width="100%"/>
</p>

<p align="center">
<a href="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/ci.yaml"><img src="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/ci.yaml/badge.svg" alt="CI"></a>
<a href="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/bundle.yaml"><img src="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/bundle.yaml/badge.svg" alt="Bundle"></a>
<a href="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/release.yaml"><img src="https://github.com/mariadb-operator/mariadb-operator-helm/actions/workflows/release.yaml/badge.svg" alt="Release"></a>
</p>

<p align="center">
<a href="https://r.mariadb.com/join-community-slack"><img alt="Slack" src="https://img.shields.io/badge/slack-join_chat-blue?logo=Slack&label=slack&style=flat"></a>
<a href="https://operatorhub.io/operator/mariadb-operator"><img src="https://img.shields.io/badge/Operator%20Hub-mariadb--operator-red" alt="Operator Hub"></a>
<a href="https://artifacthub.io/packages/olm/community-operators/mariadb-operator"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/mariadb-operator" alt="Artifact Hub"></a>
</p>

# 🦭 mariadb-operator-helm

Install [`mariadb-operator`](https://github.com/mariadb-operator/mariadb-operator) via [OLM](https://olm.operatorframework.io/) using the [helm chart](https://artifacthub.io/packages/helm/mariadb-operator/mariadb-operator).

This helm operator provides provides a 1:1 mapping between the official helm chart and the [`MariadbOperator`](https://github.com/mariadb-operator/mariadb-operator-helm/blob/main/config/samples/helm_v1alpha1_mariadboperator.yaml) CRD, allowing to install [`mariadb-operator`](https://github.com/mariadb-operator/mariadb-operator) via OLM without having to do any change in the helm chart.

Normally, you would install [`mariadb-operator`](https://github.com/mariadb-operator/mariadb-operator) providing this `values.yaml` to the helm chart:
```yaml
image:
  repository: ghcr.io/mariadb-operator/mariadb-operator
  pullPolicy: IfNotPresent
logLevel: INFO
ha:
  enabled: true
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
webhook:
  cert:
    certManager:
      enabled: true
```

This helm chart installation is abstracted in the [`MariadbOperator`](https://github.com/mariadb-operator/mariadb-operator-helm/blob/main/config/samples/helm_v1alpha1_mariadboperator.yaml) CRD, which will be reconciled by the helm operator:
```yaml
apiVersion: helm.mariadb.mmontes.io/v1alpha1
kind: MariadbOperator
metadata:
  name: mariadb-operator
spec:
  image:
    repository: ghcr.io/mariadb-operator/mariadb-operator
    pullPolicy: IfNotPresent
  logLevel: INFO
  ha:
    enabled: true
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
  webhook:
    cert:
      certManager:
        enabled: true
```

Once you have installed the operator, you will able to install a [`MariaDB`](https://github.com/mariadb-operator/mariadb-operator/blob/main/examples/manifests/mariadb_v1alpha1_mariadb.yaml) instance. Refer to the main [`mariadb-operator`](https://github.com/mariadb-operator/mariadb-operator) documentation for getting started with the rest of CRDs.

## Documentation
* [mariadb-operator](https://github.com/mariadb-operator/mariadb-operator/blob/main/README.md)
* [mariadb-operator-helm](https://github.com/mariadb-operator/mariadb-operator-helm/blob/main/README.md)

## Releases
This operator is automatically published in the following repositories whenever a new version of the [helm chart](https://artifacthub.io/packages/helm/mariadb-operator/mariadb-operator) is released:
- [k8s-operatorhub/community-operators](https://github.com/k8s-operatorhub/community-operators)
- [redhat-openshift-ecosystem/community-operators-prod](https://github.com/redhat-openshift-ecosystem/community-operators-prod)

## Roadmap
Take a look at our [roadmap](https://github.com/mariadb-operator/mariadb-operator/blob/main/ROADMAP.md) and feel free to open an issue to suggest new features.

## Contributing
We welcome and encourage contributions to this project! Please check our [contributing](https://github.com/mariadb-operator/mariadb-operator/blob/main/CONTRIBUTING.md) and [development](https://github.com/mariadb-operator/mariadb-operator/blob/main/docs/DEVELOPMENT.md) guides. PRs welcome!

## Get in touch
- [Slack](https://r.mariadb.com/join-community-slack)
- mariadb-operator@proton.me
