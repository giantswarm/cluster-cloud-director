# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.2] - 2026-01-21

### Added

- Added `fix-dns-nic-allocation.sh` Ignition script to attach DNS servers to correct network interfaces.

### Changed

- Fix a race condition when populating `/run/metadata/coreos`.
- Fix race condition in `ntpd` unit.
- Chart: Update `cluster` to v5.1.2.

## [3.1.1] - 2025-12-17

### Changed

- Chart: Update `cluster` to v5.1.1.

## [3.1.0] - 2025-12-10

### Changed

- Chart: Update `cluster` to v5.1.0.

## [3.0.0] - 2025-12-02

### Added

- Add the `priority-classes` default app, enabled by default. This app provides standardised `PriorityClass` resources like `giantswarm-critical` and `giantswarm-high`, which should replace the previous inconsistent per-app priority classes.
- Add `"helm.sh/resource-policy": keep` annotation to `VCDCluster` CR so that it doesn't get removed by Helm when uninstalling this chart. The CAPI controllers will take care of removing it, following the expected deletion order.

### Changed

- Chart: Update `cluster` to v5.0.0.

## [2.4.0] - 2025-10-29

### Changed

- Chart: Update `cluster` to v4.4.0.

## [2.3.0] - 2025-10-24

### Changed

- Chart: Update `cluster` to v4.3.0.

## [2.2.0] - 2025-10-15

### Changed

- Chart: Update `cluster` to v4.2.0.

## [2.1.0] - 2025-10-14

### Changed

- Chart: Update `cluster` to v4.1.0.

## [2.0.2] - 2025-10-10

### Changed

- Chart: Update `cluster` to v4.0.3.

## [2.0.1] - 2025-10-08

### Changed

- Chart: Update `cluster` to v4.0.2.

## [2.0.0] - 2025-09-24

### Changed

- Chart: Update `cluster` to v4.0.1.

## [1.0.0] - 2025-09-12

### Changed

- Chart: Update `cluster` to v3.0.1.
  - **BREAKING CHANGE:** Cgroups v1 is not supported anymore. The `.internal.advancedConfiguration.cgroupsv1` and `.global.nodePools.().cgroupsv1` flags have been removed.
  - Chart: Simplify containerd configuration by using a single config file for both control-plane and worker nodes.

## [0.69.1] - 2025-09-02

### Changed

- Chart: Update `cluster` to v2.6.2.

## [0.69.0] - 2025-08-25

### Changed

- Chart: Update `cluster` to v2.6.1.

## [0.68.1] - 2025-08-21

### Changed

- Chart: Update `cluster` to v2.5.1.

## [0.68.0] - 2025-07-31

### Changed

- Chart: Update `cluster` to v2.5.0.

## [0.67.0] - 2025-06-03

### Changed

- Chart: Update `cluster` to v2.3.0.
- Chart: Update `cluster` to v2.4.0.

## [0.66.1] - 2025-05-21

### Changed

- Chart: Update `cluster` to v2.2.1.

## [0.66.0] - 2025-03-18

### Changed

- Chart: Update `cluster` to v2.2.0.

## [0.65.0] - 2025-03-15

### Changed

- Chart: Update `cluster` to v2.1.1.
- Chart: Enable `coredns-extensions` and `etcd-defrag`.

## [0.64.2] - 2025-01-31

### Changed

- Make CPI helmrelease catalog configurable.

## [0.64.1] - 2025-01-23

### Added

- Add `components.containerd` to the schema and values.

## [0.64.0] - 2024-12-11

### Changed

- Chart: Update `cluster` to [v1.7.0](https://github.com/giantswarm/cluster/releases/tag/v1.7.0).
  - Add `teleport-init` systemd unit to handle initial token setup before `teleport` service starts
  - Improve `teleport` service reliability by adding proper file and service dependencies and pre-start checks

## [0.63.1] - 2024-11-13

### Fixed

- Use cloud-provider-cloud-director version from releases.

## [0.63.0] - 2024-11-07

### :warning: **Breaking change** :warning:

  - Support for Release CR's.

  <details>
  <summary>Migration steps</summary>

  * In ConfigMap `<cluster name>-userconfig` set `.Values.global.release.version` to the release version, e.g. `27.0.0`. 
  * In App `<cluster name>` set the `version` to an empty string.
  </details>

## [0.62.0] - 2024-10-21

> [!WARNING]
> This release adds all default apps to cluster-cloud-director, so the default-apps-cloud-director App is not used anymore.
> These changes in cluster-cloud-director are breaking and the cluster upgrade requires manual steps where the 
> default-apps-cloud-director App is removed before upgrading cluster-cloud-director. See details below.

### Added

- Render capi-node-labeler App CR from cluster chart.
- Render cert-exporter App CR from cluster chart and add cloud-director-specific cert-exporter config.
- Render cert-manager App CR from cluster chart and add cloud-director-specific cert-manager config.
- Render chart-operator-extensions App CR from cluster chart.
- Render cilium HelmRelease CR from cluster chart and add cloud-director-specific cilium config.
- Render cilium-servicemonitors App CR from cluster chart.
- Render coredns HelmRelease CR from cluster chart.
- Render etc-kubernetes-resources-count-exporter App CR from cluster chart.
- Render k8s-dns-node-cache App CR from cluster chart.
- Render metrics-server App CR from cluster chart.
- Render net-exporter App CR from cluster chart.
- Render network-policies HelmRelease CR from cluster chart and add cloud-director-specific network-policies config.
- Render node-exporter App CR from cluster chart and add cloud-director-specific node-exporter config.
- Render observability-bundle App CR from cluster chart.
- Render observability-policies App CR from cluster chart.
- Render security-bundle App CR from cluster chart.
- Render teleport-kube-agent App CR from cluster chart.
- Render vertical-pod-autoscaler App CR from cluster chart.
- Render vertical-pod-autoscaler-crd HelmRelease CR from cluster chart.
- Render HelmRepository CRs from cluster chart.

### Removed

- Remove cilium HelmRelease.
- Remove coredns HelmRelease.
- Remove network-policies HelmRelease.
- Remove HelmRepository CRs.

### ⚠️ Workload cluster upgrade with manual steps

The steps to upgrade a workload cluster with the unified cluster-cloud-director and default-apps-cloud-director are the following:
- Upgrade default-apps-cloud-director App to the v0.11.0 release.
- Update default-apps-cloud-director Helm value `.Values.deleteOptions.moveAppsHelmOwnershipToClusterCloudDirector` to `true`.
  - All App CRs, except observability-bundle and security-bundle, will get `app-operator.giantswarm.io/paused: true` annotation,
    so wait few minutes for Helm post-upgrade hook to apply the change to all required App CRs.
  - Check all App CRs deployed by default-apps-cloud-director to see if they reference any `extraConfigs`; if so then these must be
    added to the `cluster-cloud-director` values for use when the cluster is upgraded to `v0.62.0` (see below). For more information
    on how to do this, see the [giantswarm/cluster chart readme](https://github.com/giantswarm/cluster/tree/main/helm/cluster#apps).
- Delete default-apps-cloud-director App CR.
  - ⚠️ In case you are removing the default-apps-cloud-director App CR from your gitops repo which is using Flux, and depending on
    how Flux is configured, the default-apps-cloud-director App CR may or may not get deleted from the management cluster. In case
    Flux does not delete the default-apps-cloud-director App CR from the management cluster, make sure to delete it manually.
  - App CRs (on the MC) for all default Apps will be deleted. Wait a few minutes for this to happen.
  - Chart CRs on the workload cluster will remain untouched, so all apps will continue running.
- Upgrade the cluster-cloud-director App CR to the v0.62.0 release.
  - cluster-cloud-director will deploy all default Apps, so wait a few minutes for all Apps to be successfully deployed.
  - Chart resources on the workload cluster will get updated, as newly deployed App resources will take over the reconciliation
    of the existing Chart resources.

### Manual fixes

We're almost there, with just a couple more issues to fix manually.

#### Vertical Pod Autoscaler

The VPA CRD used to be installed as an App resource from default-apps-cloud-director, but now it's being installed as a HelmRelease
from cluster-cloud-director. Now, as a consequence of the above upgrade, we have the following situation:
- the default-apps-cloud-director App has been deleted, but the vertical-pod-autoscaler-crd Chart CRs remains in the workload cluster.
- cluster-cloud-director has been upgraded, so now it also installs the vertical-pod-autoscaler-crd HelmRelease.
- outcome: we now have a vertical-pod-autoscaler-crd HelmRelease in the MC and a vertical-pod-autoscaler-crd Chart CR in the WC.

Now we will remove the leftover vertical-pod-autoscaler-crd Chart CR in a safe way:

1. Pause the vertical-pod-autoscaler-crd Chart CR.

Add annotation `chart-operator.giantswarm.io/paused: "true"` to the vertical-pod-autoscaler-crd Chart CR in the workload cluster:

```sh
kubectl annotate -n giantswarm chart vertical-pod-autoscaler-crd chart-operator.giantswarm.io/paused="true" --overwrite
```

2. Delete the vertical-pod-autoscaler-crd Chart CR in the workload cluster.

```shell
kubectl delete -n giantswarm chart vertical-pod-autoscaler-crd
```

Kubectl will probably hang, as the chart-operator finalizer is not removed (vertical-pod-autoscaler-crd
Chart CR has been paused). Proceed to the next step to remove the finalizer and unblock the deletion.

3. Remove finalizers from the vertical-pod-autoscaler-crd Chart CR

Open another terminal window and run the following command to remove the vertical-pod-autoscaler-crd Chart CR finalizers:

```shell
kubectl patch chart vertical-pod-autoscaler-crd -n giantswarm --type=json -p='[{"op": "remove", "path": "/metadata/finalizers"}]'
```

This will unblock the deletion and vertical-pod-autoscaler-crd will get removed, **without actually deleting the VPA CustomResourceDefinition**.

From now on, the VPA CustomResourceDefinition will be maintained by the vertical-pod-autoscaler HelmRelease on the management cluster.

#### Observability Platform Configuration

The observability operator is responsible for creating the `<cluster-name>-observability-platform-configuration` configmap and patching the `<cluster-name>-observability-bundle` app to reference it. This configuration is lost after upgrading the cluster app. As a result, the observability operator has to be restarted.

```shell
kubectl delete pod -n monitoring -l app.kubernetes.io/instance=observability-operator
```

## [0.61.2] - 2024-10-17

### Fixed

- Restore handling of hostEntries values.

## [0.61.1] - 2024-10-14

### Fixed

- Corrected systemd unit templating.

## [0.61.0] - 2024-10-11

### **Breaking change**.

> [!CAUTION]
> It is important that you check each of the sections in the upgrade guide below. Note that some may not apply to your specific cluster configuration. However, the cleanup section must always be run against the cluster values.

<details>
<summary>VALUES MIGRATION GUIDE (from v0.60.0)</summary>

Use the snippets below if the section applies to your chart's values:

## Control plane machineTemplate creation

`v0.61.0` moves certain values from `.Values.global.controlPlane` to `.Values.global.controlPlane.machineTemplate`.

**This applies to all clusters, do not skip this**.

```
yq eval --inplace 'with(select(.global.controlPlane.catalog != null); .global.controlPlane.machineTemplate.catalog = .global.controlPlane.catalog) |
    with(select(.global.controlPlane.diskSizeGB != null); .global.controlPlane.machineTemplate.diskSizeGB = .global.controlPlane.diskSizeGB) |
    with(select(.global.controlPlane.placementPolicy != null); .global.controlPlane.machineTemplate.placementPolicy = .global.controlPlane.placementPolicy) |
    with(select(.global.controlPlane.sizingPolicy != null); .global.controlPlane.machineTemplate.sizingPolicy = .global.controlPlane.sizingPolicy) |
    with(select(.global.controlPlane.storageProfile != null); .global.controlPlane.machineTemplate.storageProfile = .global.controlPlane.storageProfile) |
    with(select(.global.controlPlane.template != null); .global.controlPlane.machineTemplate.template = .global.controlPlane.template)' values.yaml
```

## Control plane endpoint address

If the controlPlane endpoint IP (loadbalancer for the Kubernetes API) has been statically assigned (**this likely will not apply to workload clusters**) then this value will need to be duplicated to the extraCertificateSANs list. 

```
yq eval --inplace 'with(select(.global.connectivity.network.controlPlaneEndpoint.host != null); .cluster.internal.advancedConfiguration.controlPlane.apiServer.extraCertificateSANs += [ .global.connectivity.network.controlPlaneEndpoint.host ])' values.yaml
```

## API server admission plugins

The default list is [here](https://github.com/giantswarm/cluster/blob/main/helm/cluster/templates/clusterapi/controlplane/_helpers_clusterconfiguration_apiserver.tpl#L104). If you have not extended this list then you do not need to provide a list of admission plugins at all (defaults will be used from the cluster chart). If you have enabled additional plugins then you will need to run the command below.

```
yq eval --inplace 'with(select(.internal.apiServer.enableAdmissionPlugins != null); .cluster.providerIntegration.controlPlane.kubeadmConfig.clusterConfiguration.apiServer.additionalAdmissionPlugins = .internal.apiServer.enableAdmissionPlugins)' values.yaml
```

## API server feature gates

There is no default list of feature gates in the shared cluster chart, so if you have any values under `.internal.apiServer.featureGates` then these must be migrated to the new location.

```
yq eval --inplace 'with(select(.internal.apiServer.featureGates != null); .cluster.providerIntegration.controlPlane.kubeadmConfig.clusterConfiguration.apiServer.featureGates = .internal.apiServer.featureGates)' values.yaml
```

## Controller manager feature gates

There is no default list of feature gates in the shared cluster chart, so if you have any values under `.internal.controllerManager.featureGates` then these must be migrated to the new location.

```
yq eval --inplace 'with(select(.internal.controllerManager.featureGates != null); .cluster.providerIntegration.controlPlane.kubeadmConfig.clusterConfiguration.controllerManager.featureGates = .internal.controllerManager.featureGates)' values.yaml
```

### Extra certificate SANs for Kubernetes API

Any additional certificate SANs must be added to the extraCertificateSANs list.

```
yq eval --inplace 'with(select(.internal.apiSserver.certSANs != null); .cluster.internal.advancedConfiguration.controlPlane.apiServer.extraCertificateSANs += [ .internal.apiServer.certSANs[] ])' values.yaml
```

## OIDC config

`caFile` has been renamed to `caPem`.

```
yq eval --inplace 'with(select(.global.controlPlane.oidc.caFile != null); .global.controlPlane.oidc.caPem = .global.controlPlane.oidc.caFile)' values.yaml
```

## SSH trusted CA keys

If you are providing additional trusted CA keys for SSH authentication (other than the default Giant Swarm key) then these need to migrated to the new location.

```
yq eval --inplace 'with(select(.global.connectivity.shell.sshTrustedUserCAKeys != null); .cluster.providerIntegration.connectivity.sshSsoPublicKey = .global.connectivity.shell.sshTrustedUserCAKeys)' values.yaml
```

## NTP servers

If provided, NTP server addresses need to be migrated to the new location.

```
yq eval --inplace 'with(select(.global.connectivity.ntp.servers != null); .cluster.providerIntegration.components.systemd.timesyncd.ntp = .global.connectivity.ntp.servers)' values.yaml
```

## Upstream proxy settings

Upstream proxy configuration is no longer read from the `.global.connectivity.proxy.secretName` value so this must be removed (see the **Cleanup** section below).

## Additional notes

* `.global.connectivity.shell` is no longer used; this is deleted.
* `.global.connectivity.ntp` is no longer used; this is deleted.
* `.global.controlPlane.certSANs` is no longer used; this is deleted.
* `.global.controlPlane.image` is no longer used; this is deleted.
* `.global.controlPlane.resourceRatio` is no longer used; this is deleted.
* `.internal.sandboxContainerImage` is no longer used; this is deleted.

## Cleanup

Final tidyup to remove deprecated values:

```
yq eval --inplace 'del(.global.controlPlane.catalog) |
    del(.global.controlPlane.diskSizeGB) |
    del(.global.controlPlane.placementPolicy) |
    del(.global.controlPlane.sizingPolicy) |
    del(.global.controlPlane.storageProfile) |
    del(.global.controlPlane.template) |
    del(.global.controlPlane.certSANs) |
    del(.internal.apiServer) |
    del(.internal.controllerManager) |
    del(.global.controlPlane.oidc.caFile) |
    del(.global.connectivity.ntp) |
    del(.global.connectivity.shell) |
    del(.global.connectivity.proxy.secretName) |
    del(.internal.sandboxContainerImage) |
    del(.global.controlPlane.image) |
    del(.global.controlPlane.resourceRatio)' values.yaml
```

> [!NOTE]
> End of upgrade guide.
---
</details>

### Changed

- Use `giantswarm/cluster` chart to render `KubeadmControlPlane` resource.
- Fix disk size calculation for worker nodes.

## [0.60.0] - 2024-10-07

### **Breaking change**.

> [!CAUTION]
> Upstream proxy values must be added to the cluster values when upgrading to this chart release.

<details>
<summary>VALUES MIGRATION GUIDE (from v0.59.0)</summary>

If your cluster is behind an upstream proxy (if `.global.connectivity.proxy.enabled: true`)
then the proxy configuration must also be added to the cluster chart's values.

* `httpProxy`: upstream proxy protocol, address and port (e.g. `http://proxy-address:port`)
* `httpsProxy`: upstream proxy protocol, address and port (e.g. `http://proxy-address:port`)
* `noProxy`: comma-separated list of domains and IP CIDRs which should not be proxied (e.g. `10.10.10.0/24,internal.domain.com`)

```yaml
global:
  connectivity:
    proxy:
        enabled: true
        httpProxy: "http://10.205.105.253:3128"
        httpsProxy: "http://10.205.105.253:3128"
        noProxy: "vcd.domain.com,10.205.105.0/24"
```

> [!NOTE]
> End of upgrade guide.
---
</details>

### Changed

- Migrated all worker resources (`KubeadmConfigTemplate`, `MachineDeployment`) to be rendered from the shared `cluster` chart.
- Bump Cilium `0.27.0` -> `0.28.0`.
- Bump Coredns `1.21.0` -> `1.22.0`.
- Allow `.Values.global.managementCluster` in values schema.

## [0.59.0] - 2024-09-26

### **Breaking change**.

> [!CAUTION]
> The cluster name must be added to the cluster values when upgrading to this chart release.

<details>
<summary>How to migrate values (from v0.58.0)</summary>

The cluster's name must be added to the cluster values in order to satisfy the updated values
schema. This can be done by adding the existing cluster name to the `cluster` values. For example,
where the cluster is named `test`:

```yaml
global:
  metadata:
    name: test
```
</details>

### Changed

- Initial integration of shared `cluster` chart to render `Cluster` resource.

## [0.58.0] - 2024-09-24

### **Breaking change**.

> [!CAUTION]
> Upgrading to this chart release will cause all worker nodes to be replaced.

<details>
<summary>How to migrate values (from `v0.57.0` or later)</summary>

Using `yq`, migrate to the new values layout with the following command:

```bash
yq eval --inplace 'with(select(.global.providerSpecific.nodeClasses != null);    .global.providerSpecific.nodeClasses as $classes | with(.global.nodePools[]; . *= $classes[.class])) |
    del(.global.nodePools[].class) |
    del(.global.providerSpecific.nodeClasses)' values.yaml
```
</details>

### Changed

- Move Helm values from each `.global.providerSpecific.nodeClasses.$<class>` to any nodePool which references that class.
- Deleted Helm values property `.global.nodeClasses`.

### Changed

> Increase `HelmReleases` retries count to 50.

## [0.57.0] - 2024-09-07

### Changed

> [!WARNING]
> This release requires the Flatcar template name to be suffixed with `-gs`. Please ensure
> that VM templates are correctly named.

- Set `kubeProxyReplacement` to `'true'` instead of deprecated value `strict` in cilium values.
- Suffix Flatcar image name with `-gs`.

## [0.56.2] - 2024-07-25

### Changed

- Update to custom patch 1.5.1-gs of CPI to address LB health monitor upgrade issue until upstream patch is available.

## [0.56.1] - 2024-07-18

### Changed

- Rollback CPI from `1.6.0` to `1.5.0` due to VCD version incompatibility.

## [0.56.0] - 2024-07-15

### Changed

- Bump Kubernetes to `1.27.14`.

## [0.55.0] - 2024-07-15

### Changed

- Bump Kubernetes to `1.26.14`.

## [0.54.1] - 2024-07-11

### Fixed

- Run `kubeadm` after the static route service to fix race condition.

## [0.54.0] - 2024-06-25

### Added

- Add `.global.connectivity.localRegistryCache` Helm values and support for in-cluster, local registry cache mirrors in containerd configuration.
  In such cases, the registry should be exposed via node ports and containerd connects via that port at 127.0.0.1 via HTTP (only allowed for this single use case).

### Changed

- Update example cluster manifest.
- Move static routes to `set-static-routes` unit and use it as drop-in to `systemd-networkd`.

### Removed

- Stop setting `defaultPolicies.remove=true` in `cilium-app`.

### Fixed

- Fixed `containerd` config file generation when multiple registries are set with authentication

## [0.53.1] - 2024-06-08

### Changed

- Update values schema to allow `.Values.baseDomain` and `.Values.connectivity.containerRegistries` to support chart migration.

## [0.53.0] - 2024-06-08

### Changed

- Remove the interface to set `etcd` and `coredns` images to let kubeadm take care of it.
- Bump CPI to upstream `1.6.0`.
- Bump CSI to upstream `1.5.0`.

### **Breaking change**.

<details>
<summary>How to migrate values</summary>

Using `yq`, migrate to the new values layout with the following command:

```bash
#!/bin/bash
yq eval --inplace 'with(select(.connectivity != null);  .global.connectivity = .connectivity) |
    with(select(.baseDomain != null);                   .global.connectivity.baseDomain = .baseDomain) |
    with(select(.metadata != null);                     .global.metadata = .metadata) |
    with(select(.controlPlane.certSANs != null);        .internal.apiServer.certSANs = .controlPlane.certSANs) |
    with(select(.controlPlane != null);                 .global.controlPlane = .controlPlane) |
    with(select(.nodePools != null);                    .global.nodePools = .nodePools) |
    with(select(.providerSpecific != null);             .global.providerSpecific = .providerSpecific) |
    with(select(.kubectlImage != null);                 .internal.kubectlImage = .kubectlImage) |

    del(.connectivity) |
    del(.baseDomain) |
    del(.metadata) |
    del(.controlPlane) |
    del(.nodePools) |
    del(.providerSpecific) |
    del(.kubectlImage)' values.yaml
```

</details>

### Changed

- Move Helm values property `.Values.connectivity` to `.Values.global.connectivity`.
- Move Helm values property `.Values.baseDomain` to `.Values.global.connectivity.baseDomain`.
- Move Helm values property `.Values.metadata` to `.Values.global.metadata`.
- Move Helm values property `.Values.controlPlane.certSANs` to `.Values.internal.apiServer.certSANs`.
- Move Helm values property `.Values.controlPlane` to `.Values.global.controlPlane`.
- Move Helm values property `.Values.nodePools` to `.Values.global.nodePools`.
- Move Helm values property `.Values.providerSpecific` to `.Values.global.providerSpecific`.
- Move Helm values property `.Values.kubectlImage` to `.Values.internal.kubectlImage`.

## [0.52.1] - 2024-05-16

### Fixed

- Wait 3 seconds after restarting `networkd` to avoid race condition with first static route.

## [0.52.0] - 2024-05-15

### Changed

- Add static route commands to network setup script in Flatcar systemd unit.

## [0.51.0] - 2024-05-07

### Changed

- Updated machine template to newer Flatcar version which includes teleport v15.1.7 binaries. **WARNING: This will roll CP and worker nodes.**
- Enable teleport by default.
- Temporarily enable `additionalProperties` to facilitate chart refactoring.

## [0.50.0] - 2024-04-16

### Changed

- Changed schema to include a default nodeClass `default` used by a default nodePool `worker`. Customers and GS currently set these so they will be overwritten. These defaults are to be used by E2E tests. Other settings are defaulted in the chart such as Kubernetes version, VM template, catalog...

### Added

- Add teleport support to SSH into nodes (disabled by default)
- Enable DNS network policies from network-policies-app.

### Removed

- Remove default network policies from cilium-app.

## [0.16.0] - 2024-04-02

### Added

- Add support for Ignition (Flatcar). Backwards compatible with Ubuntu but using ignition requires `cluster-api-provider-cloud-director-app` in version `v0.8.0` or above.

## [0.15.2] - 2024-03-14

### Changed

- Add security fields to update hook jobs.

## [0.15.1] - 2024-03-08

### Changed

- Bump `kubectl` image to `1.25.15`.

## [0.15.0] - 2024-03-08

### Changed

- Switch container registry to `gsoci.azurecr.io`.
- Adapt cleanup hook for cluster policies.
- Enforce PSS by default (requires k8s 1.25 or newer).

## [0.14.6] - 2024-02-19

### Fixed

- Only create Cilium resources if Cilium CRDs exist.

## [0.14.5] - 2024-02-14

### Changed

- Bump netpol app which disables the coredns `CiliumClusterwideNetworkPolicy`.

## [0.14.4] - 2024-02-13

### Added

- Add flag for `podSecurityStandards`.

## [0.14.3] - 2024-02-12

### Changed

- Add helm hook annotations to helmrelease cleanup job.

## [0.14.2] - 2024-01-25

### Added

- Add flags to disable PSPs.
- Add CiliumNetworkPolicies

## [0.14.1] - 2024-01-18

### Added

- Add `global.metadata.preventDeletion` to add the [deletion prevention label](https://docs.giantswarm.io/advanced/deletion-prevention/) to Cluster resources.
- Fix indentation issue in `preventDeletion` calls.

### Changed

- Bump CoreDNS HelmRelease to `1.21.0` and enable Renovate.
- Bump Cilium HelmRelease to `0.19.0` and enable Renovate.
- Enable Renovate on CPI and NetPol HelmReleases.

## [0.14.0] - 2023-12-20

### Added

- Installs network-policies-app as a HelmRelease that will lock all the communication to `giantswarm` and `kube-system` namespaces.

## [0.13.2] - 2023-12-12

### Added

- Expose Storage Class properties from the CSI.

### Changed

- Lock network traffic by default in `giantswarm` and `kube-system` namespaces (default deny).
- Remove `TTLAfterFinished` flag for Kubernetes 1.25 compatibility (enabled by default).
- Remove `ExpandPersistentVolumes` flag for Kubernetes 1.27 compatibility (enabled by default).
- Remove `logtostderr` for Kubernetes 1.27 compatibility (output is logged to stderr by default).
- Bump CPI to `0.2.9`.

### Fixed

- Fix containerd config that was breaking in newer flatcar versions.

## [0.13.1] - 2023-09-18

### Fixed

- Remove leftover `helmchart` CRs.

### Added

- Add validation pattern for NodePool name.
- Add configurable host entries.

## [0.13.0] - 2023-07-26

### Fixed

- Fix `.connectivity.proxy.secretName` defaulting to `<clusterName>-cluster-values`.

### Added

- Set value for `controller-manager` `terminated-pod-gc-threshold` to `125` ( consistent with vintage ) 

### Changed

- :boom: **Breaking:** Stop deploying default network policies with the `cilium-app`. This means the cluster will be more locked down and all network traffic is blocked by default. Can be disabled with `network.allowAllEgress` setting. Required `default-apps-cloud-director` version `v0.5.4` or later.
- Consolidate containerd `config.toml` into a single file to address [#1737](https://github.com/giantswarm/roadmap/issues/1737)
- Add host OS user `nobody` to `root` group to enable node-exporter's `filesystem` collector to access the host filesystem.

## [0.12.2] - 2023-07-03

### Added

- Bind `kube-scheduler` metrics to 0.0.0.0.

## [0.12.1] - 2023-06-30

### Added

- Support for `--oidc-groups-prefix`.

## [0.12.0] - 2023-06-28

<details>
<summary>How to migrate from 0.11.x</summary>

To migrate values from cluster-cloud-director 0.11.x, we provide below [yq](https://mikefarah.gitbook.io/yq/) script, which assumes your values (not a ConfigMap!) are available in the file `values.yaml`. The file's content will be overwritten.

**Note:** For the following three proprties, the structure has changes and you will have to modify your values manually.

- `.apiServer.enableAdmissionPlugins` was a string property with comma-separated values. This gets replaced by `.internal.apiServer.enableAdmissionPlugins`, which is an array property where each admission plugin name should be a separate array item.
- `.apiServer.featureGates` was an array property, where each item had the form `FeatureGateName=<true|false>`. This gets replaced by `.internal.apiServer.featureGates`, which is an object. Here the feature gate name is supposed to be the key and the value is the according boolean.
- `.controllerManager.featureGates` was an array property, where each item had the form `FeatureGateName=<true|false>`. This gets replaced by `.internal.controllerManager.featureGates`, which is an object. Here the feature gate name is supposed to be the key and the value is the according boolean.

```bash
yq eval --inplace '
  with(select(.cloudDirector != null); .providerSpecific = .cloudDirector) |
  with(select(.cloudProvider != null); .providerSpecific.cloudProviderInterface = .cloudProvider) |
  with(select(.cluster.parentUid != null); .internal.parentUid = .cluster.parentUid) |
  with(select(.cluster.skipRDE != null); .internal.skipRde = .cluster.skipRDE) |
  with(select(.cluster.useAsManagementCluster != null); .internal.useAsManagementCluster = .cluster.useAsManagementCluster) |
  with(select(.clusterDescription != null); .metadata.description = .clusterDescription) |
  with(select(.clusterLabels != null); .metadata.labels = .clusterLabels) |
  with(select(.connectivity.network.ntp != null); .connectivity.ntp = .connectivity.network.ntp) |
  with(select(.controllerManager != null); .internal.controllerManager = .controllerManager) |
  with(select(.kubernetesVersion != null); .internal.kubernetesVersion = .kubernetesVersion) |
  with(select(.nodeClasses != null); .providerSpecific.nodeClasses = .nodeClasses) |
  with(select(.oidc != null); .controlPlane.oidc = .oidc) |
  with(select(.organization != null); .metadata.organization = .organization) |
  with(select(.osUsers != null); .connectivity.shell.osUsers = .osUsers) |
  with(select(.proxy != null); .connectivity.proxy = .proxy) |
  with(select(.rdeId != null); .internal.rdeId = .rdeId) |
  with(select(.servicePriority != null); .metadata.servicePriority = .servicePriority) |
  with(select(.sshTrustedUserCAKeys != null); .connectivity.shell.sshTrustedUserCAKeys = .sshTrustedUserCAKeys) |
  with(select(.userContext != null); .providerSpecific.userContext = .userContext) |
  with(select(.vmNamingTemplate != null); .providerSpecific.vmNamingTemplate = .vmNamingTemplate) |
  with(select(.connectivity.network.loadBalancer != null); .connectivity.network.loadBalancers = .connectivity.network.loadBalancer) |
  del(.cloudDirector) |
  del(.cloudProvider) |
  del(.cluster) |
  del(.clusterDescription) |
  del(.clusterLabels) |
  del(.clusterName) |
  del(.connectivity.network.ntp) |
  del(.controllerManager) |
  del(.includeClusterResourceSet) |
  del(.kubernetesVersion) |
  del(.nodeClasses) |
  del(.oidc) |
  del(.organization) |
  del(.osUsers) |
  del(.providerSpecific.userContext.secretRef.useSecretRef) |
  del(.proxy) |
  del(.rdeId) |
  del(.servicePriority) |
  del(.sshTrustedUserCAKeys) |
  del(.userContext) |
  del(.vmNamingTemplate) |
  del(.connectivity.network.loadBalancer)
' ./values.yaml
```

</details>

### Added

- Default controlplane endpoint port to 6443.

### Changed

- Normalize values schema according to `schemalint` v2.
- :boom: Breaking schema changes:
  - `.apiServer.certSANs` moved to `.controlPlane.certSANs`
  - Former `.apiServer.enableAdmissionPlugins`, now `.internal.apiServer.enableAdmissionPlugins`,  changed to array of strings
  - Former `.apiServer.featureGates`, now `.internal.apiServer.featureGates`, changed to array of objects
  - Former `.controllerManager.featureGates`, now `.internal.controllerManager.featureGates`, changed to array of objects
  - `.cluster.parentUid` moved to `.internal.parentUid`
  - `.cluster.skipRDE` moved to `.internal.skipRde`
  - `.cluster.useAsManagementCluster` moved to `.internal.useAsManagementCluster`
  - `.clusterLabels` moved to `.metadata.labels`
  - `.clusterDescription` moved to `.metadata.description`
  - `.cloudDirector` moved to `.providerSpecific`
  - `.connectivity.network.ntp` moved to `.connectivity.ntp`
  - `.controllerManager` moved to `.internal.controllerManager`
  - `.kubernetesVersion` moved to `.internal.kubernetesVersion`
  - `.nodeClasses` moved to `.providerSpecific.nodeClasses`
  - `.servicePriority` moved to `.metadata.servicePriority`
  - `.oidc` moved to `.controlPlane.oidc`
  - `.osUsers` moved to `.connectivity.osUsers`
  - `.organization` moved to `.metadata.organization`
  - `.proxy` moved to `.connectivity.proxy`
  - `.cloudProvider` moved to `.providerSpecific.cloudProviderInterface`
  - `.rdeId` moved to `.internal.rdeId`
  - `.sshTrustedUserCAKeys` moved to `.connectivity.shell.sshTrustedUserCAKeys`
  - `.userContext` moved to `.providerSpecific`
  - `.vmNamingTemplate` moved to `.providerSpecific`
  - Removed `.includeClusterResourceSet`
  - Set `additionalProperties` to false on all objects that don't make use of them.
- Non-breaking schema changes and clean-ups
  - Remove unused `.clusterName` value
  - Added properties `.cluster-shared`, `.managementCluster`, and `.provider`, which are injected into values from different sources and have to be permitted explicitlxy since `additionalProperties` is false now.
  - Change the `.controlPlane.replicas` default to 1
  - Add a default value of 1 to `.nodePools.*.replicas`
  - Mark `.connectivity.containerRegistries` as optional (not required)

## [0.11.2] - 2023-06-26

### Added

- Add default value to schema for `.controlPlane.replicas`.
- Add dependencies for HelmRelease CRs (so `coredns` and CPI wait for `cilium` to be installed first).

### Changed

- Normalize values schema according to `schemalint` v2.
- Update cilium to 0.10.0 (and add tolerations to hubble relay and UI).
- Update `cloud-provider-cloud-director` to `0.2.8`.

### Fixed

- Values schema: remove invalid key `replicas` from `.controlPlane.replicas`

## [0.11.1] - 2023-05-25

### Fixed

- Fix connectivity key in vcdcluster template.

## [0.11.0] - 2023-05-23

### Added

- Add audilog configuration.
- :boom: **Breaking:** Refactor api for network parameters to apply the standard interface for all providers.
- :boom: **Breaking:** Default CIDR blocks for pods changed from `100.96.0.0/11` to `10.244.0.0/16`.
- :boom: **Breaking:** Default CIDR blocks for services changed from `100.64.0.0/13` to `172.31.0.0/16`.

## [0.10.0] - 2023-05-15

**Info on breaking changes:** This release makes incompatible changes to the values schema. See details for info on how to migrate.

<details>
<summary>How to migrate from 0.9.0</summary>

To migrate values from cluster-cloud-director 0.9.0, we provide below [yq](https://mikefarah.gitbook.io/yq/) script, which assumes your values (not a ConfigMap!) are available in the file `values.yaml`. Note that the file will be overwritten.

```bash
yq eval --inplace '
  with(select(.ntp != null); .network.ntp = .ntp) |
  del(.ntp)
' ./values.yaml
```

</details>

### Added

- Set `/var/lib/kubelet` permissions to `0750` to fix `node-exporter` issue.

### Changed

- Bump `cloud-provider-cloud-director` to `0.2.7` to inject ClusterID to NamedDisks.

### Fixed

- :boom: **Breaking:** Adapt `values.yaml` to align with `values.schema.json` and set NTP settings in `.network.ntp` and adapt template.

## [0.9.0] - 2023-04-05

### Added

- Add `default-test` HelmRepository (catalog) for debugging.
- Added annotations (title, description, examples) to the values schema.
- Values schema: Added type definition for properties where they were missing.
- Values schema: Add default values

### Changed

- Bump `cloud-provider-cloud-director` to `0.2.6` to support Kubernetes 1.24.
- Edit examples.
- :boom: **Breaking:** Install CoreDNS (`coredns-app`) using `HelmRelease` CR and stop deploying it with `cluster-shared` resource set.
- Bump infrastructureApiVersion from v1beta1 to v1beta2.
- Bump coredns-app to 1.15.1 to support Kubernetes 1.24.
- Specify JSON Schema draft of values schema.

### Removed

- Remove `cluster-shared` dependency.

### Fixed

- Fix values schema for `.network.ntp` object.

## [0.8.1] - 2023-03-23

### Added

- Make cloud provider `VirtualServiceSharedIP` configurable.

### Fixed

- Fix RBAC for pre-upgrade hook.

## [0.8.0] - 2023-03-17

### Changed

- :boom: **Breaking:** Use cilium kube-proxy replacement.

## [0.7.4] - 2023-03-17

### Changed

Bump cloud provider to v0.2.5 (fix).

## [0.7.3] - 2023-03-17

### Changed

- Bump cloud provider to v0.2.4.

## [0.7.2] - 2023-03-16

### Fixed

- Fixed breaking whitespaces.

## [0.7.1] - 2023-03-13

### Added

- Add configurable ntp on nodes.

## [0.7.0] - 2023-03-07

### Added

- :boom: **Breaking:** Add HelmRelease CRs for CNI (cilium) and CPI/CSI (cloud-provider-cloud-director). Please note this is compatible only with `default-apps-cloud-director` version `0.4.0` and newer.
- Add configurable `apiServer.certSANs`.
- Add machine health checks for worker nodes.

## [0.6.1] - 2023-01-31

### Changed

- Moved Static routes script from `postKubeadmCommand` to `preKubeadmCommand`.

## [0.6.0] - 2023-01-30

### Added

- Add configurable cluster CR labels.
- Add schema for `.kubectlImage`.
- Add support for `diskSizeGB`.
- Add support for setting node labels using `customNodeLabels`.
- Add support for setting node taints using `customNodeTaints`.
- Include common labels for `kubeadmcontrolplane.spec.machinetemplate.metadata`.
- Fix KubeadmConfigTemplate templating when multiple ssh users are provided.
- Support registry configuration for containerd.
- Support sshd configuration for cert-based SSH.
- Support for VM naming with go templates.

## [0.5.0] - 2022-12-18

### Added

- Add items schema for `.network.staticRoutes`.
- Add properties schema for `.nodePools` and `.nodeClasses`.
- Support `extraOvdcNetworks` to attach multiple network to machines.

### Fixed

- Use oneshot service to set persistent static routes.

## [0.4.4] - 2022-12-01

### Fixed

- Remove `serviceDomain` from `Cluster` spec to fix invalid noProxy value.
- Remove chart name (including app version) from selectors to enable upgrades.

## [0.4.3] - 2022-11-28

### Added

- Add configurable static routes.

## [0.4.2] - 2022-11-28

### Fixed

- Fix containerd proxy configuration by removing duplicate `files` section.

## [0.4.1] - 2022-11-28

### Fixed

- Decouple `preKubeadmCommands` section from `containerdProxyConfig` function in `helpers.tpl`.

## [0.4.0] - 2022-11-25

### Changed

- Restructure nodepools and nodeclasses for GitOps.
- Allow core-component configuration via `kubeadm --patches`.
- Configure API priority and fairness flags based on node resources.
- Import the `cluster-shared` chart to apply additional `coredns` resources in a Workload Cluster via `ClusterResourceSets`
- Adapt control-plane configuration by comparing CAPO.
- Expose etcd metrics for prometheus.
- ⚠️ **Breaking:** Configure encryption at REST. This requires `{{ include "resource.default.name" $ }}-encryption-provider-config` secret with `encyrption` key to be present in the cluster (can be provisioned with [encryption-provider-operator](https://github.com/giantswarm/encryption-provider-operator)).
- Adapt kube-proxy configuration for monitoring.

## [0.3.0] - 2022-11-15

### Added

- Use `cluster-apps-operator` generated `containerd` proxy configuration, if `proxy` is enabled
- It's possible to define an alternative `containerd` proxy configuration via `values.proxy.secretName`. Primarily used for bootstrapping new management clusters.

## [0.2.4] - 2022-10-25

### Changed

- Make proxy enabled/disabled explicit to match useability of cluster-aws chart.
- Enforce using secretRef for authentication.

## [0.2.3] - 2022-10-04

### Added

- Add servicePriority label on cluster object in the chart.
- Move specs to helpers.tpl to have single source of truth.

### CHANGED

- Set `revisionHistoryLimit` in `MachineDeployment` as `0` for `deletion-blocker-operator`.
- Removed `defaultStorageClass` since it was moved to the cloud provider.
- Align Proxy values with CAPA in values file.

## [0.2.2] - 2022-08-18

### CHANGED

- Align values file structure with other providers.
- Removed cluster name from values file in favour of the chart's name.

### Added

- Allow setting etcd image repository and tag.
- Set the default etcd version to 3.5.4 (kubeadm default is 3.5.0 which is not
  recommended in production).
- Set the default etcd image to retagged Giant Swarm one.
- Added `skipRDE` switch which include `RdeID` to `VCDCluster` when __NO_RDE__ is used to fix `clusterctl move`.

## [0.2.0] - 2022-08-09

### CHANGED

- Moved vipSubnet from `cluster-api-provider-cloud-director-app` to `cluster-cloud-director`

## [0.1.3] - 2022-08-03

### CHANGED

- Added `cluster-apps-operator.giantswarm.io/watching: ""` label to `Cluster` CR.

## [0.1.2] - 2022-07-25

### FIXED

- Fixed validating data error when controlPlaneEndpoint properties are not set.

## [0.1.1] - 2022-07-07

### FIXED

- Fixed breaking whitespaces in values files.

## [0.1.0] - 2022-06-28

### CHANGED

- Updated repo config to push to cluster app catalog.
- Added chart schema.
- Moved parameters from cloudDirector to cluster.
- Remove kube version from machine objects.
- kubeadmConfigTemplateRevision and mtRevision.

### Added

- Initial chart implementation.
- Support for node pools.
- Added VCDCluster parameters to match CRD.
- Nodepool and nodeclass support.

[Unreleased]: https://github.com/giantswarm/cluster-cloud-director/compare/v3.1.2...HEAD
[3.1.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v3.1.1...v3.1.2
[3.1.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.4.0...v3.0.0
[2.4.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.3.0...v2.4.0
[2.3.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.2.0...v2.3.0
[2.2.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.0.2...v2.1.0
[2.0.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.69.1...v1.0.0
[0.69.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.69.0...v0.69.1
[0.69.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.68.1...v0.69.0
[0.68.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.68.0...v0.68.1
[0.68.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.67.0...v0.68.0
[0.67.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.66.1...v0.67.0
[0.66.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.66.0...v0.66.1
[0.66.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.65.0...v0.66.0
[0.65.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.64.2...v0.65.0
[0.64.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.64.1...v0.64.2
[0.64.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.64.0...v0.64.1
[0.64.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.63.1...v0.64.0
[0.63.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.63.0...v0.63.1
[0.63.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.62.0...v0.63.0
[0.62.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.61.2...v0.62.0
[0.61.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.61.1...v0.61.2
[0.61.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.61.0...v0.61.1
[0.61.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.60.0...v0.61.0
[0.60.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.59.0...v0.60.0
[0.59.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.58.0...v0.59.0
[0.58.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.57.0...v0.58.0
[0.57.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.56.2...v0.57.0
[0.56.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.56.1...v0.56.2
[0.56.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.56.0...v0.56.1
[0.56.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.55.0...v0.56.0
[0.55.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.54.1...v0.55.0
[0.54.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.54.0...v0.54.1
[0.54.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.53.1...v0.54.0
[0.53.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.53.0...v0.53.1
[0.53.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.52.1...v0.53.0
[0.52.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.52.0...v0.52.1
[0.52.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.51.0...v0.52.0
[0.51.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.50.0...v0.51.0
[0.50.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.16.0...v0.50.0
[0.16.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.15.2...v0.16.0
[0.15.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.15.1...v0.15.2
[0.15.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.15.0...v0.15.1
[0.15.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.6...v0.15.0
[0.14.6]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.5...v0.14.6
[0.14.5]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.4...v0.14.5
[0.14.4]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.3...v0.14.4
[0.14.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.2...v0.14.3
[0.14.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.1...v0.14.2
[0.14.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.14.0...v0.14.1
[0.14.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.13.2...v0.14.0
[0.13.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.13.1...v0.13.2
[0.13.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.13.0...v0.13.1
[0.13.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.12.2...v0.13.0
[0.12.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.12.1...v0.12.2
[0.12.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.12.0...v0.12.1
[0.12.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.11.2...v0.12.0
[0.11.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.11.1...v0.11.2
[0.11.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.11.0...v0.11.1
[0.11.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.8.1...v0.9.0
[0.8.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.8.0...v0.8.1
[0.8.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.7.4...v0.8.0
[0.7.4]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.7.3...v0.7.4
[0.7.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.7.2...v0.7.3
[0.7.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.7.1...v0.7.2
[0.7.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.6.1...v0.7.0
[0.6.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.4.4...v0.5.0
[0.4.4]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.4.3...v0.4.4
[0.4.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.4...v0.3.0
[0.2.4]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.0...v0.2.2
[0.2.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-cloud-director/releases/tag/v0.1.0
