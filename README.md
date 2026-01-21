# cluster-cloud-director - test

This repository contains the Helm chart used for deploying CAPI clusters via [CAPVCD](https://github.com/vmware/cluster-api-provider-cloud-director). It deploys:

- CAPI resources
- `cilium` as CNI in `kube-proxy` replacement mode (see [Limitations](#Limitations) section below)
- CPI and CSI for VMware Cloud Director

## Authentication to VCD

Authentication to the VCD API is achieved as part of the cluster creation process to abide by user-defined resource quotas. It can be achieved by referencing a secret (preferred method) or specifying creds/token in the VCDCluster definition. **We only support referencing a secret in this app**.

Before deploying a cluster, make sure there is a secret containing the base64 encoded [API token](https://docs.vmware.com/en/VMware-Cloud-Director/10.3/VMware-Cloud-Director-Tenant-Portal-Guide/GUID-A1B3B2FA-7B2C-4EE1-9D1B-188BE703EEDE.html) of the VCD user in the namespace where you will deploy the cluster.

### API token

Using an API token is preferred for authentication over credentials as it can be revoked easily (If both credentials and an API token were specified, the credentials would be ignored). In order to create an API token:

* In the top right corner of the navigation bar, click your user name, and select User preferences.
* Under the Access Tokens section, click New.
* Enter a name for the token, and click Create.

The generated API token appears. You must copy the token because it appears only once. After you click OK, you cannot retrieve this token again, you can only revoke it.

``` yaml
apiVersion: v1
kind: Secret
metadata:
  name: vcd-credentials
  namespace: default
type: Opaque
data:
  refreshToken: "xxxxxxxxxxx"
```

Or

`kubectl create secret generic vcd-credentials --from-literal refreshToken="xxxxxxxxx"`

## Create a cluster

Edit the values file (at least the fields that aren't identified as optional), reference the secret containing the user's VCD credentials by name under `providerSpecific > userContext > secretRef > secretName` and install the chart in the same namespace.

In the UI `vipSubnet` is the field in `Networking > Edge Gateway > IP Management > IP Allocations > Allocated IPs > IP Block`. For instance in Ikoula `178.170.32.1/24`

Example of a values.yaml file for Cloud provider Ikoula with minimum input (making use of default values):

```yaml
baseDomain: "cluster.local"
metadata:
  description: "glados test cluster"
  organization: "giantswarm"

providerSpecific:
  site: "https://vmware.ikoula.com"
  org: "xxx"
  ovdc: "xxx"
  ovdcNetwork: "xxx"
  userContext:
    secretRef:
      useSecretRef: true
      secretName: vcd-credentials

controlPlane:
  replicas: 3
  catalog: "giantswarm"
  template: "ubuntu-2004-kube-v1.22.5"
  sizingPolicy: "m1.large"

connectivity:
  network:
    loadBalancer:
      vipSubnet: "178.170.32.1/24"
  proxy:
    enabled: true

nodePools:
  worker:
    replicas: 2
    catalog: "giantswarm"
    template: "ubuntu-2004-kube-v1.22.5"
    sizingPolicy: "m1.large"

internal:
  kubernetesVersion: "v1.22.5+vmware.1"
```

## Limitations

With this chart we deploy `cilium` CNI to the cluster in `kube-proxy` replacement mode. This requires us to specify `k8sServiceHost` value in the `cilium` chart which we chose to be a templated domain name:

```yaml
k8sServiceHost: api.{{ include "resource.default.name" $ }}.{{ .Values.baseDomain }}
```

You can see it in [cilium-helmrelease.yaml](helm/cluster-cloud-director/templates/cilium-helmrelease.yaml).

This means cluster nodes won't come up Ready before this domain is set to the IP of the Kubernetes API server (it's defined in the `Cluster` CR under `.spec.controlPlaneEndpoint.host`). In Giant Swarm clusters we use [dns-operator-route53](https://github.com/giantswarm/dns-operator-route53) to create the records (public DNS resolution is then required).

## Update chart's schema docs

After making a change to the schema, run `schemadocs` to update the README documentation.

https://github.com/giantswarm/schemadocs

```yaml
VALUES_SCHEMA=$(find ./helm -maxdepth 2 -name values.schema.json)
CHART_README=$(find ./helm -maxdepth 2 -name README.md)

schemadocs generate $VALUES_SCHEMA -o $CHART_README
```

## Generate values from schema

Do not make changes to the `values.yaml` file manually. That file should be automatically generated from the schema.

https://github.com/giantswarm/helm-values-gen

```yaml
cd helm/cluster-cloud-director

helm-values-gen values.schema.json -o values.yaml -f
```
