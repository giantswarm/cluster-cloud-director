# cluster-cloud-director values

<!-- DOCS_START -->

### 
Properties within the `.internal` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.apiServer` |**None**|**Type:** `object`<br/>|
| `internal.apiServer.enableAdmissionPlugins` | **Admission plugins** - List of admission plugins to be passed to the API server via the --enable-admission-plugins flag.|**Type:** `array`<br/>**Default:** `["DefaultStorageClass","DefaultTolerationSeconds","LimitRanger","MutatingAdmissionWebhook","NamespaceLifecycle","PersistentVolumeClaimResize","Priority","ResourceQuota","ServiceAccount","ValidatingAdmissionWebhook"]`|
| `internal.apiServer.enableAdmissionPlugins[*]` | **Plugin**|**Type:** `string`<br/>**Examples:** `"DefaultStorageClass", "Priority"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.apiServer.featureGates` | **Feature gates** - API server feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[{"enabled":true,"name":"TTLAfterFinished"}]`|
| `internal.apiServer.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.apiServer.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.apiServer.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.controllerManager` | **Controller manager**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates` | **Feature gates** - Controller manager feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[{"enabled":true,"name":"ExpandPersistentVolumes"},{"enabled":true,"name":"TTLAfterFinished"}]`|
| `internal.controllerManager.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.controllerManager.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.kubernetesVersion` | **Kubernetes version**|**Type:** `string`<br/>|
| `internal.parentUid` | **Management cluster UID** - If set, create the cluster from a specific management cluster associated with this UID.|**Type:** `string`<br/>|
| `internal.rdeId` | **Runtime defined entity (RDE) identifier** - This cluster's RDE ID in the VCD API.|**Type:** `string`<br/>|
| `internal.sandboxContainerImage` | **Sandbox Container image**|**Type:** `object`<br/>|
| `internal.sandboxContainerImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"tkg/pause"`|
| `internal.sandboxContainerImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"projects.registry.vmware.com/"`|
| `internal.sandboxContainerImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"3.7"`|
| `internal.skipRde` | **Skip RDE** - Set to true if the API schema extension is installed in the correct version in VCD to create CAPVCD entities in the API. Set to false otherwise.|**Type:** `boolean`<br/>|
| `internal.useAsManagementCluster` | **Display as management cluster**|**Type:** `boolean`<br/>**Default:** `false`|

### Connectivity
Properties within the `.connectivity` top-level object
Configurations related to cluster connectivity such as container registries.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `connectivity.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `object`<br/>**Default:** `{}`|
| `connectivity.containerRegistries.*` |**None**|**Type:** `array`<br/>|
| `connectivity.containerRegistries.*[*]` |**None**|**Type:** `object`<br/>|
| `connectivity.containerRegistries.*[*].credentials` | **Credentials** - Credentials for the endpoint.|**Type:** `object`<br/>|
| `connectivity.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `string`<br/>|
| `connectivity.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `string`<br/>|
| `connectivity.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `connectivity.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `connectivity.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `string`<br/>|
| `connectivity.network` | **Network**|**Type:** `object`<br/>|
| `connectivity.network.controlPlaneEndpoint` | **Control plane endpoint** - Kubernetes API endpoint.|**Type:** `object`<br/>|
| `connectivity.network.controlPlaneEndpoint.host` | **Host**|**Type:** `string`<br/>|
| `connectivity.network.controlPlaneEndpoint.port` | **Port number**|**Type:** `integer`<br/>**Default:** `6443`|
| `connectivity.network.extraOvdcNetworks` | **Extra OVDC networks** - OVDC networks to attach VMs to, additionally.|**Type:** `array`<br/>|
| `connectivity.network.extraOvdcNetworks[*]` |**None**|**Type:** `string`<br/>|
| `connectivity.network.loadBalancers` | **Load Balancers**|**Type:** `object`<br/>|
| `connectivity.network.loadBalancers.vipSubnet` | **Virtual IP subnet** - Virtual IP CIDR for the external network.|**Type:** `string`<br/>|
| `connectivity.network.pods` | **Pods**|**Type:** `object`<br/>|
| `connectivity.network.pods.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `connectivity.network.pods.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>|
| `connectivity.network.services` | **Services**|**Type:** `object`<br/>|
| `connectivity.network.services.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `connectivity.network.services.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>|
| `connectivity.network.staticRoutes` | **Static routes**|**Type:** `array`<br/>|
| `connectivity.network.staticRoutes[*]` |**None**|**Type:** `object`<br/>|
| `connectivity.network.staticRoutes[*].destination` | **Destination** - IPv4 address range in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.128.0.0/16"`<br/>|
| `connectivity.network.staticRoutes[*].via` | **Via**|**Type:** `string`<br/>|
| `connectivity.ntp` | **Time synchronization (NTP)** - Servers/pools to synchronize this cluster's clocks with.|**Type:** `object`<br/>|
| `connectivity.ntp.pools` | **Pools**|**Type:** `array`<br/>|
| `connectivity.ntp.pools[*]` | **Pool**|**Type:** `string`<br/>**Example:** `"ntp.ubuntu.com"`<br/>|
| `connectivity.ntp.servers` | **Servers**|**Type:** `array`<br/>|
| `connectivity.ntp.servers[*]` | **Server**|**Type:** `string`<br/>|
| `connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `object`<br/>|
| `connectivity.proxy.enabled` | **Enable**|**Type:** `boolean`<br/>|
| `connectivity.proxy.secretName` | **Secret name** - Name of a secret resource used by containerd to obtain the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables. If empty the value will be defaulted to <clusterName>-cluster-values.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9-]{0,63}$`<br/>|
| `connectivity.shell` | **Shell access**|**Type:** `object`<br/>|
| `connectivity.shell.osUsers` | **OS Users** - Configuration for OS users in cluster nodes.|**Type:** `array`<br/>**Default:** `[{"name":"giantswarm","sudo":"ALL=(ALL) NOPASSWD:ALL"}]`|
| `connectivity.shell.osUsers[*]` | **User**|**Type:** `object`<br/>|
| `connectivity.shell.osUsers[*].name` | **Name** - Username of the user.|**Type:** `string`<br/>**Value pattern:** `^[a-z][-a-z0-9]+$`<br/>|
| `connectivity.shell.osUsers[*].sudo` | **Sudoers configuration** - Permissions string to add to /etc/sudoers for this user.|**Type:** `string`<br/>|
| `connectivity.shell.sshTrustedUserCAKeys` | **Trusted SSH cert issuers** - CA certificates of issuers that are trusted to sign SSH user certificates.|**Type:** `array`<br/>**Default:** `["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4cvZ01fLmO9cJbWUj7sfF+NhECgy+Cl0bazSrZX7sU vault-ca@vault.operations.giantswarm.io"]`|
| `connectivity.shell.sshTrustedUserCAKeys[*]` |**None**|**Type:** `string`<br/>|

### Control plane
Properties within the `.controlPlane` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `controlPlane.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Example:** `"giantswarm"`<br/>|
| `controlPlane.certSANs` | **Subject alternative names (SAN)** - Alternative names to encode in the API server's certificate.|**Type:** `array`<br/>|
| `controlPlane.certSANs[*]` | **SAN**|**Type:** `string`<br/>|
| `controlPlane.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `controlPlane.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `controlPlane.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `controlPlane.dns` | **DNS container image**|**Type:** `object`<br/>|
| `controlPlane.dns.imageRepository` | **Repository**|**Type:** `string`<br/>**Example:** `"projects.registry.vmware.com/tkg"`<br/>**Default:** `"projects.registry.vmware.com/tkg"`|
| `controlPlane.dns.imageTag` | **Tag**|**Type:** `string`<br/>**Example:** `"v1.7.0_vmware.12"`<br/>**Default:** `"v1.7.0_vmware.12"`|
| `controlPlane.etcd` | **Etcd container image**|**Type:** `object`<br/>|
| `controlPlane.etcd.imageRepository` | **Repository**|**Type:** `string`<br/>**Example:** `"giantswarm"`<br/>**Default:** `"giantswarm"`|
| `controlPlane.etcd.imageTag` | **Tag**|**Type:** `string`<br/>**Example:** `"3.5.4-0-k8s"`<br/>**Default:** `"3.5.4-0-k8s"`|
| `controlPlane.image` | **Node container image**|**Type:** `object`<br/>|
| `controlPlane.image.repository` | **Repository**|**Type:** `string`<br/>**Example:** `"projects.registry.vmware.com/tkg"`<br/>**Default:** `"projects.registry.vmware.com/tkg"`|
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
| `controlPlane.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Example:** `"ubuntu-2004-kube-v1.22.5"`<br/>|

### Kubectl image
Properties within the `.kubectlImage` top-level object
Used by cluster-shared library chart to configure coredns in-cluster.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `kubectlImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/kubectl"`|
| `kubectlImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"quay.io"`|
| `kubectlImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"1.23.5"`|

### Metadata
Properties within the `.metadata` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `string`<br/>|
| `metadata.labels` | **Labels** - These labels are added to the Kubernetes resourses defining this cluster.|**Type:** `object`<br/>|
| `metadata.labels.PATTERN` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-zA-Z0-9/\._-]+$`<br/>**Value pattern:** `^[a-zA-Z0-9\._-]+$`<br/>|
| `metadata.organization` | **Organization**|**Type:** `string`<br/>|
| `metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `string`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.nodePools` top-level object
Groups of worker nodes with identical configuration.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `nodePools.*` |**None**|**Type:** `object`<br/>|
| `nodePools.*.class` | **Node class** - A valid node class name, as specified in VMware Cloud Director (VCD) settings > Node classes.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9-]+$`<br/>|
| `nodePools.*.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Default:** `1`|

### VMware Cloud Director (VCD) settings
Properties within the `.providerSpecific` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `providerSpecific.cloudProviderInterface` | **Cloud provider interface (CPI)**|**Type:** `object`<br/>|
| `providerSpecific.cloudProviderInterface.enableVirtualServiceSharedIP` | **Share IPs in virtual services** - If enabled, multiple virtual services can share the same virtual IP address.|**Type:** `boolean`<br/>**Default:** `true`|
| `providerSpecific.cloudProviderInterface.oneArm` | **One-arm** - If enabled, use an internal IP for the virtual service with a NAT rule to expose the external IP. Otherwise the virtual service will be exposed directly with the external IP.|**Type:** `object`<br/>|
| `providerSpecific.cloudProviderInterface.oneArm.enabled` | **Enable**|**Type:** `boolean`<br/>**Default:** `false`|
| `providerSpecific.nodeClasses` | **Node classes** - Re-usable node configuration.|**Type:** `object`<br/>|
| `providerSpecific.nodeClasses.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Example:** `"giantswarm"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeLabels` | **Node labels**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints` | **Node taints**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*]` | **Custom node taint**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].effect` |One of NoSchedule, PreferNoSchedule or NoExecute|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].key` |Name of the label on a node|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.customNodeTaints[*].value` |value of the label identified by the key|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.nodeClasses.PATTERN.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Example:** `"ubuntu-2004-kube-v1.22.5"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]+$`<br/>|
| `providerSpecific.org` | **Organization** - VCD organization name.|**Type:** `string`<br/>|
| `providerSpecific.ovdc` | **OvDC name** - Name of the organization virtual datacenter (OvDC) to create this cluster in.|**Type:** `string`<br/>|
| `providerSpecific.ovdcNetwork` | **OvDC network** - VCD network to connect VMs.|**Type:** `string`<br/>|
| `providerSpecific.site` | **Endpoint** - VCD endpoint URL in the format https://VCD_HOST, without trailing slash.|**Type:** `string`<br/>|
| `providerSpecific.userContext` | **VCD API access token**|**Type:** `object`<br/>|
| `providerSpecific.userContext.secretRef` | **Secret reference**|**Type:** `object`<br/>|
| `providerSpecific.userContext.secretRef.secretName` | **Name** - Name of the secret containing the VCD API token.|**Type:** `string`<br/>|
| `providerSpecific.vmNamingTemplate` | **VM naming template** - Go template to specify the VM naming convention.|**Type:** `string`<br/>**Example:** `"mytenant-{{ .machine.Name | sha256sum | trunc 7 }}"`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `string`<br/>**Default:** `"k8s.test"`|
| `cluster-shared` | **Library chart**|**Type:** `object`<br/>|
| `managementCluster` | **Management cluster name** - The Cluster API management cluster that manages this cluster.|**Type:** `string`<br/>|
| `provider` | **Cluster API provider name**|**Type:** `string`<br/>|



<!-- DOCS_END -->
