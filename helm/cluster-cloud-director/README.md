# cluster-cloud-director values

<!-- DOCS_START -->

### 

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `cluster-shared` | **Library chart**|**Type:** `object`<br/>|
| `controlPlane.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Default:** `"giantswarm"`|
| `controlPlane.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `controlPlane.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `controlPlane.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `controlPlane.image` | **Node container image** - Set to 'gsoci.azurecr.io/giantswarm' for ignition (Flatcar) and 'projects.registry.vmware.com/tkg' for cloud-init (Ubuntu).|**Type:** `object`<br/>|
| `controlPlane.image.repository` | **Repository**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io/giantswarm"`|
| `controlPlane.oidc` | **OIDC authentication**|**Type:** `object`<br/>|
| `controlPlane.oidc.caFile` | **Certificate authority file** - Path to identity provider's CA certificate in PEM format.|**Type:** `string`<br/>|
| `controlPlane.oidc.clientId` | **Client ID** - OIDC client identifier to identify with.|**Type:** `string`<br/>|
| `controlPlane.oidc.groupsClaim` | **Groups claim** - Name of the identity token claim bearing the user's group memberships.|**Type:** `string`<br/>|
| `controlPlane.oidc.groupsPrefix` | **Groups prefix** - Prefix prepended to groups values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `controlPlane.oidc.issuerUrl` | **Issuer URL** - URL of the provider which allows the API server to discover public signing keys, not including any path. Discovery URL without the '/.well-known/openid-configuration' part.|**Type:** `string`<br/>|
| `controlPlane.oidc.usernameClaim` | **Username claim** - Name of the identity token claim bearing the unique user identifier.|**Type:** `string`<br/>|
| `controlPlane.oidc.usernamePrefix` | **Username prefix** - Prefix prepended to username values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `controlPlane.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>|
| `controlPlane.replicas` | **Number of nodes** - Number of control plane instances to create. Must be an odd number.|**Type:** `integer`<br/>**Default:** `1`|
| `controlPlane.resourceRatio` | **Resource ratio** - Ratio between node resources and apiserver resource requests.|**Type:** `integer`<br/>**Default:** `8`|
| `controlPlane.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>|
| `controlPlane.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>|
| `controlPlane.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Default:** `"flatcar-stable-3815.2.1-kube-v1.25.16"`|
| `global.connectivity.baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `object`<br/>**Default:** `{}`|
| `global.connectivity.containerRegistries.*` |**None**|**Type:** `array`<br/>|
| `global.connectivity.containerRegistries.*[*]` |**None**|**Type:** `object`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials` | **Credentials** - Credentials for the endpoint.|**Type:** `object`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `string`<br/>|
| `global.connectivity.network` | **Network**|**Type:** `object`<br/>|
| `global.connectivity.network.controlPlaneEndpoint` | **Control plane endpoint** - Kubernetes API endpoint.|**Type:** `object`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.host` | **Host**|**Type:** `string`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.port` | **Port number**|**Type:** `integer`<br/>**Default:** `6443`|
| `global.connectivity.network.extraOvdcNetworks` | **Extra OVDC networks** - OVDC networks to attach VMs to, additionally.|**Type:** `array`<br/>|
| `global.connectivity.network.extraOvdcNetworks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.hostEntries` | **Host entries**|**Type:** `array`<br/>|
| `global.connectivity.network.hostEntries[*]` |**None**|**Type:** `object`<br/>|
| `global.connectivity.network.hostEntries[*].fqdn` | **FQDN**|**Type:** `string`<br/>|
| `global.connectivity.network.hostEntries[*].ip` | **IP address**|**Type:** `string`<br/>|
| `global.connectivity.network.loadBalancers` | **Load Balancers**|**Type:** `object`<br/>|
| `global.connectivity.network.loadBalancers.vipSubnet` | **Virtual IP subnet** - Virtual IP CIDR for the external network.|**Type:** `string`<br/>|
| `global.connectivity.network.pods` | **Pods**|**Type:** `object`<br/>|
| `global.connectivity.network.pods.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `global.connectivity.network.pods.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>|
| `global.connectivity.network.services` | **Services**|**Type:** `object`<br/>|
| `global.connectivity.network.services.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `global.connectivity.network.services.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>|
| `global.connectivity.network.staticRoutes` | **Static routes**|**Type:** `array`<br/>|
| `global.connectivity.network.staticRoutes[*]` |**None**|**Type:** `object`<br/>|
| `global.connectivity.network.staticRoutes[*].destination` | **Destination** - IPv4 address range in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.128.0.0/16"`<br/>|
| `global.connectivity.network.staticRoutes[*].via` | **Via**|**Type:** `string`<br/>|
| `global.connectivity.ntp` | **Time synchronization (NTP)** - Servers/pools to synchronize this cluster's clocks with.|**Type:** `object`<br/>|
| `global.connectivity.ntp.pools` | **Pools**|**Type:** `array`<br/>|
| `global.connectivity.ntp.pools[*]` | **Pool**|**Type:** `string`<br/>**Example:** `"ntp.ubuntu.com"`<br/>|
| `global.connectivity.ntp.servers` | **Servers**|**Type:** `array`<br/>|
| `global.connectivity.ntp.servers[*]` | **Server**|**Type:** `string`<br/>|
| `global.connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `object`<br/>|
| `global.connectivity.proxy.enabled` | **Enable**|**Type:** `boolean`<br/>|
| `global.connectivity.proxy.secretName` | **Secret name** - Name of a secret resource used by containerd to obtain the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables. If empty the value will be defaulted to <clusterName>-cluster-values.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9-]{0,63}$`<br/>|
| `global.connectivity.shell` | **Shell access**|**Type:** `object`<br/>|
| `global.connectivity.shell.osUsers` | **OS Users** - Configuration for OS users in cluster nodes.|**Type:** `array`<br/>**Default:** `[{"name":"giantswarm","sudo":"ALL=(ALL) NOPASSWD:ALL"}]`|
| `global.connectivity.shell.osUsers[*]` | **User**|**Type:** `object`<br/>|
| `global.connectivity.shell.osUsers[*].name` | **Name** - Username of the user.|**Type:** `string`<br/>**Value pattern:** `^[a-z][-a-z0-9]+$`<br/>|
| `global.connectivity.shell.osUsers[*].sudo` | **Sudoers configuration** - Permissions string to add to /etc/sudoers for this user.|**Type:** `string`<br/>|
| `global.connectivity.shell.sshTrustedUserCAKeys` | **Trusted SSH cert issuers** - CA certificates of issuers that are trusted to sign SSH user certificates.|**Type:** `array`<br/>**Default:** `["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4cvZ01fLmO9cJbWUj7sfF+NhECgy+Cl0bazSrZX7sU vault-ca@vault.operations.giantswarm.io"]`|
| `global.connectivity.shell.sshTrustedUserCAKeys[*]` |**None**|**Type:** `string`<br/>|
| `global.controlPlane.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Default:** `"giantswarm"`|
| `global.controlPlane.certSANs` | **Subject alternative names (SAN)** - Alternative names to encode in the API server's certificate.|**Type:** `array`<br/>|
| `global.controlPlane.certSANs[*]` | **SAN**|**Type:** `string`<br/>|
| `global.controlPlane.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `global.controlPlane.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `global.controlPlane.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `global.controlPlane.image` | **Node container image** - Set to 'gsoci.azurecr.io/giantswarm' for ignition (Flatcar) and 'projects.registry.vmware.com/tkg' for cloud-init (Ubuntu).|**Type:** `object`<br/>|
| `global.controlPlane.image.repository` | **Repository**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io/giantswarm"`|
| `global.controlPlane.oidc` | **OIDC authentication**|**Type:** `object`<br/>|
| `global.controlPlane.oidc.caFile` | **Certificate authority file** - Path to identity provider's CA certificate in PEM format.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.clientId` | **Client ID** - OIDC client identifier to identify with.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsClaim` | **Groups claim** - Name of the identity token claim bearing the user's group memberships.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsPrefix` | **Groups prefix** - Prefix prepended to groups values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.issuerUrl` | **Issuer URL** - URL of the provider which allows the API server to discover public signing keys, not including any path. Discovery URL without the '/.well-known/openid-configuration' part.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernameClaim` | **Username claim** - Name of the identity token claim bearing the unique user identifier.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernamePrefix` | **Username prefix** - Prefix prepended to username values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>|
| `global.controlPlane.replicas` | **Number of nodes** - Number of control plane instances to create. Must be an odd number.|**Type:** `integer`<br/>**Default:** `1`|
| `global.controlPlane.resourceRatio` | **Resource ratio** - Ratio between node resources and apiserver resource requests.|**Type:** `integer`<br/>**Default:** `8`|
| `global.controlPlane.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>|
| `global.controlPlane.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>|
| `global.controlPlane.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Default:** `"flatcar-stable-3815.2.1-kube-v1.25.16"`|
| `global.metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `string`<br/>|
| `global.metadata.labels` | **Labels** - These labels are added to the Kubernetes resources defining this cluster.|**Type:** `object`<br/>|
| `global.metadata.labels.PATTERN` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-zA-Z0-9/\._-]+$`<br/>**Value pattern:** `^[a-zA-Z0-9\._-]+$`<br/>|
| `global.metadata.organization` | **Organization**|**Type:** `string`<br/>|
| `global.metadata.preventDeletion` | **Prevent cluster deletion**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `string`<br/>**Default:** `"highest"`|
| `global.podSecurityStandards.enforced` | **Enforced Pod Security Standards** - Use PSSs instead of PSPs.|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.apiServer` |**None**|**Type:** `object`<br/>|
| `internal.apiServer.certSANs` | **Subject alternative names (SAN)** - Alternative names to encode in the API server's certificate.|**Type:** `array`<br/>|
| `internal.apiServer.certSANs[*]` | **SAN**|**Type:** `string`<br/>|
| `internal.apiServer.enableAdmissionPlugins` | **Admission plugins** - List of admission plugins to be passed to the API server via the --enable-admission-plugins flag.|**Type:** `array`<br/>**Default:** `["DefaultStorageClass","DefaultTolerationSeconds","LimitRanger","MutatingAdmissionWebhook","NamespaceLifecycle","PersistentVolumeClaimResize","Priority","ResourceQuota","ServiceAccount","ValidatingAdmissionWebhook"]`|
| `internal.apiServer.enableAdmissionPlugins[*]` | **Plugin**|**Type:** `string`<br/>**Examples:** `"DefaultStorageClass", "Priority"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.apiServer.featureGates` | **Feature gates** - API server feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[]`|
| `internal.apiServer.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.apiServer.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.apiServer.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.ciliumNetworkPolicy` | **CiliumNetworkPolicies**|**Type:** `object`<br/>|
| `internal.ciliumNetworkPolicy.enabled` | **Enable CiliumNetworkPolicies** - Installs the network-policies-app (deny all by default) if set to true|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.controllerManager` | **Controller manager**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates` | **Feature gates** - Controller manager feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[]`|
| `internal.controllerManager.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.controllerManager.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.kubernetesVersion` | **Kubernetes version** - For cloud-init (Ubuntu), append the version with '+vmware.1'.|**Type:** `string`<br/>**Default:** `"v1.25.16"`|
| `internal.parentUid` | **Management cluster UID** - If set, create the cluster from a specific management cluster associated with this UID.|**Type:** `string`<br/>|
| `internal.rdeId` | **Runtime defined entity (RDE) identifier** - This cluster's RDE ID in the VCD API.|**Type:** `string`<br/>|
| `internal.sandboxContainerImage` | **Sandbox Container image (pause container)**|**Type:** `object`<br/>|
| `internal.sandboxContainerImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/pause"`|
| `internal.sandboxContainerImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.sandboxContainerImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"3.9"`|
| `internal.skipRde` | **Skip RDE** - Set to true if the API schema extension is installed in the correct version in VCD to create CAPVCD entities in the API. Set to false otherwise.|**Type:** `boolean`<br/>|
| `internal.teleport` | **Teleport**|**Type:** `object`<br/>|
| `internal.teleport.enabled` | **Enable teleport**|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.teleport.proxyAddr` | **Teleport proxy address**|**Type:** `string`<br/>**Default:** `"teleport.giantswarm.io:443"`|
| `internal.useAsManagementCluster` | **Display as management cluster**|**Type:** `boolean`<br/>**Default:** `false`|
| `kubectlImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/kubectl"`|
| `kubectlImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `kubectlImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"1.25.15"`|
| `managementCluster` | **Management cluster name** - The Cluster API management cluster that manages this cluster.|**Type:** `string`<br/>|
| `nodePools.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `nodePools.PATTERN.class` | **Node class** - A valid node class name, as specified in VMware Cloud Director (VCD) settings > Node classes.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>**Value pattern:** `^[a-z0-9-]+$`<br/>|
| `nodePools.PATTERN.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>**Default:** `1`|
| `nodePools.worker` | **Default nodePool**|**Type:** `object`<br/>|
| `nodePools.worker.class` | **Node class** - A valid node class name, as specified in VMware Cloud Director (VCD) settings > Node classes.|**Type:** `string`<br/>**Default:** `"default"`|
| `nodePools.worker.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Default:** `2`|
| `provider` | **Cluster API provider name**|**Type:** `string`<br/>|
| `providerSpecific.cloudProviderInterface` | **Cloud provider interface (CPI)**|**Type:** `object`<br/>|
| `providerSpecific.cloudProviderInterface.enableVirtualServiceSharedIP` | **Share IPs in virtual services** - If enabled, multiple virtual services can share the same virtual IP address.|**Type:** `boolean`<br/>**Default:** `true`|
| `providerSpecific.cloudProviderInterface.oneArm` | **One-arm** - If enabled, use an internal IP for the virtual service with a NAT rule to expose the external IP. Otherwise the virtual service will be exposed directly with the external IP.|**Type:** `object`<br/>|
| `providerSpecific.cloudProviderInterface.oneArm.enabled` | **Enable**|**Type:** `boolean`<br/>**Default:** `false`|
| `providerSpecific.containerStorageInterface` | **Container storage interface (CSI)**|**Type:** `object`<br/>|
| `providerSpecific.containerStorageInterface.storageClass` | **Pre-create storage class** - Pre-create storage class for the VCD CSI.|**Type:** `object`<br/>|
| `providerSpecific.containerStorageInterface.storageClass.delete` | **Pre-create delete storage class**|**Type:** `object`<br/>|
| `providerSpecific.containerStorageInterface.storageClass.delete.isDefault` | **Default storage class**|**Type:** `boolean`<br/>**Default:** `true`|
| `providerSpecific.containerStorageInterface.storageClass.delete.vcdStorageProfileName` | **Name of storage profile in VCD**|**Type:** `string`<br/>**Default:** `""`|
| `providerSpecific.containerStorageInterface.storageClass.enabled` | **Enable**|**Type:** `boolean`<br/>**Default:** `true`|
| `providerSpecific.containerStorageInterface.storageClass.retain` | **Pre-create retain storage class**|**Type:** `object`<br/>|
| `providerSpecific.containerStorageInterface.storageClass.retain.isDefault` | **Default storage class**|**Type:** `boolean`<br/>**Default:** `false`|
| `providerSpecific.containerStorageInterface.storageClass.retain.vcdStorageProfileName` | **Name of storage profile in VCD**|**Type:** `string`<br/>**Default:** `""`|
| `providerSpecific.nodeClasses` | **Node classes** - Re-usable node configuration.|**Type:** `object`<br/>|
| `providerSpecific.nodeClasses.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>**Default:** `"giantswarm"`|
| `providerSpecific.nodeClasses.PATTERN.customNodeLabels` | **Node labels**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints` | **Node taints**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*]` | **Custom node taint**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].effect` | **Node taint effect** - One of NoSchedule, PreferNoSchedule or NoExecute.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].key` | **Node taint key** - Name of the label on a node.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].value` | **Node taint value** - Value of the label identified by the key.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>**Default:** `"flatcar-stable-3815.2.1-kube-v1.25.16"`|
| `providerSpecific.nodeClasses.default` | **Default nodeClass**|**Type:** `object`<br/>|
| `providerSpecific.nodeClasses.default.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Default:** `"giantswarm"`|
| `providerSpecific.nodeClasses.default.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `providerSpecific.nodeClasses.default.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `providerSpecific.nodeClasses.default.customNodeTaints` | **Node taints**|**Type:** `array`<br/>|
| `providerSpecific.nodeClasses.default.customNodeTaints[*]` | **Custom node taint**|**Type:** `object`<br/>|
| `providerSpecific.nodeClasses.default.customNodeTaints[*].effect` | **Node taint effect** - One of NoSchedule, PreferNoSchedule or NoExecute.|**Type:** `string`<br/>|
| `providerSpecific.nodeClasses.default.customNodeTaints[*].key` | **Node taint key** - Name of the label on a node.|**Type:** `string`<br/>|
| `providerSpecific.nodeClasses.default.customNodeTaints[*].value` | **Node taint value** - Value of the label identified by the key.|**Type:** `string`<br/>|
| `providerSpecific.nodeClasses.default.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `providerSpecific.nodeClasses.default.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>|
| `providerSpecific.nodeClasses.default.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>|
| `providerSpecific.nodeClasses.default.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>|
| `providerSpecific.nodeClasses.default.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Default:** `"flatcar-stable-3815.2.1-kube-v1.25.16"`|
| `providerSpecific.org` | **Organization** - VCD organization name.|**Type:** `string`<br/>|
| `providerSpecific.ovdc` | **OvDC name** - Name of the organization virtual datacenter (OvDC) to create this cluster in.|**Type:** `string`<br/>|
| `providerSpecific.ovdcNetwork` | **OvDC network** - VCD network to connect VMs.|**Type:** `string`<br/>|
| `providerSpecific.site` | **Endpoint** - VCD endpoint URL in the format https://VCD_HOST, without trailing slash.|**Type:** `string`<br/>|
| `providerSpecific.userContext` | **VCD API access token**|**Type:** `object`<br/>|
| `providerSpecific.userContext.secretRef` | **Secret reference**|**Type:** `object`<br/>|
| `providerSpecific.userContext.secretRef.secretName` | **Name** - Name of the secret containing the VCD API token.|**Type:** `string`<br/>|
| `providerSpecific.vmBootstrapFormat` | **Ignition or cloud-init for OS initialization** - Select either 'ignition' for Flatcar or 'cloud-config' for other OSes (e.g. Ubuntu).|**Type:** `string`<br/>**Default:** `"ignition"`|
| `providerSpecific.vmNamingTemplate` | **VM naming template** - Go template to specify the VM naming convention.|**Type:** `string`<br/>**Example:** `"mytenant-{{ .machine.Name | sha256sum | trunc 7 }}"`<br/>|



<!-- DOCS_END -->
