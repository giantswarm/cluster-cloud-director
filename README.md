# cluster-cloud-director

This repository contains the Helm chart used for deploying CAPI clusters via [CAPVCD](https://github.com/vmware/cluster-api-provider-cloud-director).

## Authentication to VCD

Authentication to the VCD API is achieved as part of the cluster creation process to abide by user-defined resource quotas. At the moment, it can be achieved by referencing a secret (preferred method) or specifying creds/token in the VCDCluster definition.

Before deploying a cluster, make sure there is a secret containing the base64 encoded user credentials or [API token](https://docs.vmware.com/en/VMware-Cloud-Director/10.3/VMware-Cloud-Director-Tenant-Portal-Guide/GUID-A1B3B2FA-7B2C-4EE1-9D1B-188BE703EEDE.html) of the VCD user in the namespace where you will deploy the cluster.

### API token

Using an API token is preferred for authentication over credentials as it can be revoked easily. If both credentials and an API token are specified, the credentials will be ignored. In order to create an API token:

* In the top right corner of the navigation bar, click your user name, and select User preferences.
* Under the Access Tokens section, click New.
* Enter a name for the token, and click Create.

The generated API token appears. You must copy the token because it appears only once. After you click OK, you cannot retrieve this token again, you can only revoke it.

``` yaml
apiVersion: v1
kind: Secret
metadata:
  name: xav-secret
  namespace: default
type: Opaque
data:
  username: ""
  password: ""
  refreshToken: "xxxxxxxxxxx"
```

## Create a cluster

Edit the values file (at least the fields that aren't identified as optional), reference the secret containing the user's VCD credentials by name under `userContext > secretRef > secretName` and install the chart in the same namespace.

In the UI `vipSubnet` is the field in `Networking > Edge Gateway > IP Management > IP Allocations > Allocated IPs > IP Block`. For instance in Ikoula:

``` yaml
vcd:
  vipSubnet: "178.170.32.1/24"
```

Example of a values.yaml file for Cloud provider Ikoula with minimum input (making use of default values):

```yaml
cluster:
  kubernetesVersion: "v1.22.5+vmware.1"
  name: "xav"
  organization: "giantswarm"
  loadBalancer:
    vipSubnet: ""

cloudDirector:
  site: "https://vmware.ikoula.com"
  org: "xxxx"
  ovdc: "xxxx"
  ovdcNetwork: "xxxx"

userContext:
  secretRef:
    useSecretRef: true
    secretName: "xav-secret"

controlPlane:
  replicas: 1
  catalog: "giantswarm"
  template: "ubuntu-2004-kube-v1.22.5"
  sizingPolicy: ""
  placementPolicy: ""
  storageProfile: ""

nodeClasses:
  - name: worker
    catalog: "giantswarm"
    template: "ubuntu-2004-kube-v1.22.5"
    sizingPolicy: ""
    placementPolicy: ""
    storageProfile: ""

nodePools:
  - class: worker
    name: worker
    replicas: 2
  - class: worker
    name: lazy
    replicas: 1
```
