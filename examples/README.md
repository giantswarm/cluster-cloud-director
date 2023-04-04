# cluster-cloud-director usage examples

The examples provided here follow the implementation in a Giant Swarm cluster where the App platform is installed.

The CPI (Cloud Provider Interface), CSI (Container Storage Interface) and CNI (Container Network Interface) are embedded in the cluster chart and installed via fluxcd `helmreleases` from our Helm catalogs.

Additional components are required to get a working Giant Swarm cluster. Those components are bundled in a default-apps app which is installed via the Giant Swarm App platform.

## Giant Swarm cluster image pulling issues.

If you encounter issues during provisioning due to the node not being able to pull images during kubeadm, you may need to configure containerd to use [Docker credentials](https://github.com/giantswarm/cluster-cloud-director/blob/main/helm/cluster-cloud-director/values.yaml#L130).

``` yaml
  extraConfigs:
  - kind: secret
    name: container-registries-configuration
    namespace: giantswarm
    priority: 25
```