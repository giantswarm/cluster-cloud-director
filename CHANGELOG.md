# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Set `kubeProxyReplacement` to `'true'` instead of deprecated value `strict` in cilium values.

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

[Unreleased]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.56.2...HEAD
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
