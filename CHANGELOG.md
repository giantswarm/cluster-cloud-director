# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.2...HEAD
[0.1.2]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/giantswarm/cluster-cloud-director/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-cloud-director/releases/tag/v0.1.0
