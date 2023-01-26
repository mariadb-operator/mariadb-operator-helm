# 🦭 mariadb-operator-helm
[![CI](https://github.com/mmontes11/mariadb-operator-helm/actions/workflows/ci.yaml/badge.svg)](https://github.com/mmontes11/mariadb-operator-helm/actions/workflows/ci.yaml)

Install [mariadb-operator](https://github.com/mmontes11/mariadb-operator) via [OLM](https://olm.operatorframework.io/) using the [helm chart](https://artifacthub.io/packages/helm/mariadb-operator/mariadb-operator).

This is the Operator SDK version of `mariadb-operator`. It provides a 1:1 mapping between the official helm chart and the [`MariadbOperator`](https://github.com/mmontes11/mariadb-operator-helm/blob/main/config/samples/helm_v1alpha1_mariadboperator.yaml) CRD, allowing to install `mariadb-operator` via OLM without having to do any change in the helm chart.

Normally, you would install `mariadb-operator` providing this `values.yaml` to the helm chart:
```yaml
image:
  repository: mmontes11/mariadb-operator
  pullPolicy: IfNotPresent
logLevel: INFO
ha:
  enabled: true
metrics:
  enalbed: true
  serviceMonitor:
    enabled: true
webhook:
  enabled: true
  certificate:
    certManager: true
```

This helm chart installation is abstracted in the `MariadbOperator` CRD, which will be reconciled by the current helm operator:
```yaml
apiVersion: helm.mariadb.mmontes.io/v1alpha1
kind: MariadbOperator
metadata:
  name: mariadb-operator
spec:
  image:
    repository: mmontes11/mariadb-operator
    pullPolicy: IfNotPresent
  logLevel: INFO
  ha:
    enabled: true
  metrics:
    enalbed: true
    serviceMonitor:
      enabled: true
  webhook:
    enabled: true
    certificate:
      certManager: true
```

Once you have installed the operator, you are able to install a `MariaDB` instance. Refer to the documentation for getting started with the rest of CRDs.

## Documentation
* [mariadb-operator](https://github.com/mmontes11/mariadb-operator/blob/main/README.md)
* [mariadb-operator-helm](https://github.com/mmontes11/mariadb-operator-helm/blob/main/README.md)

## Roadmap
Take a look at our [🛣️ roadmap](https://github.com/mmontes11/mariadb-operator/blob/main/ROADMAP.md) and feel free to open an issue to suggest new features.

## Contributing
If you want to report a 🐛 or you think something can be improved, please check our [contributing](https://github.com/mmontes11/mariadb-operator/blob/main/CONTRIBUTING.md) guide and take a look at our open [issues](https://github.com/mmontes11/mariadb-operator/issues). PRs are welcome!
