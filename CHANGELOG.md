# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Make proxy enabled/disabled explicit to match useability of cluster-aws chart.

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
- kubeAdmConfigTemplateRevision and mtRevision.

### Added

- Initial chart implementation.
- Support for node pools.
- Added VCDCluster parameters to match CRD.
- Nodepool and nodeclass support.

[Unreleased]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.3...HEAD
[0.2.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.2.0...v0.2.2
[0.2.0]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-cloud-director/releases/tag/v0.1.0
