# cluster-cloud-director values

<!-- DOCS_START -->

### 
Properties within the `.internal` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.kubectlImage` | **Kubectl image** - Used by cluster-shared library chart to configure coredns in-cluster.|**Type:** `object`<br/>|
| `internal.kubectlImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/kubectl"`|
| `internal.kubectlImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.kubectlImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"1.27.14"`|
| `internal.parentUid` | **Management cluster UID** - If set, create the cluster from a specific management cluster associated with this UID.|**Type:** `string`<br/>|
| `internal.rdeId` | **Runtime defined entity (RDE) identifier** - This cluster's RDE ID in the VCD API.|**Type:** `string`<br/>|
| `internal.skipRde` | **Skip RDE** - Set to true if the API schema extension is installed in the correct version in VCD to create CAPVCD entities in the API. Set to false otherwise.|**Type:** `boolean`<br/>|
| `internal.useAsManagementCluster` | **Display as management cluster**|**Type:** `boolean`<br/>**Default:** `false`|

### Components
Properties within the `.global.components` object
Advanced configuration of components that are running on all nodes.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.components.containerd` | **Containerd** - Configuration of containerd.|**Type:** `object`<br/>|
| `global.components.containerd.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `object`<br/>**Default:** `{}`|
| `global.components.containerd.containerRegistries.*` | **Registries** - Container registries and mirrors|**Type:** `array`<br/>|
| `global.components.containerd.containerRegistries.*[*]` | **Registry**|**Type:** `object`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials` | **Credentials**|**Type:** `object`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `string`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `string`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.components.containerd.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `string`<br/>|
| `global.components.containerd.localRegistryCache` | **Local registry caches configuration** - Enable local cache via http://127.0.0.1:<PORT>.|**Type:** `object`<br/>|
| `global.components.containerd.localRegistryCache.enabled` | **Enable local registry caches** - Flag to enable local registry cache.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.components.containerd.localRegistryCache.mirroredRegistries` | **Registries to cache locally** - A list of registries that should be cached.|**Type:** `array`<br/>**Default:** `[]`|
| `global.components.containerd.localRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `string`<br/>|
| `global.components.containerd.localRegistryCache.port` | **Local port for the registry cache** - Port for the local registry cache under: http://127.0.0.1:<PORT>.|**Type:** `integer`<br/>**Default:** `32767`|
| `global.components.containerd.managementClusterRegistryCache` | **Management cluster registry cache** - Caching container registry on a management cluster level.|**Type:** `object`<br/>|
| `global.components.containerd.managementClusterRegistryCache.enabled` | **Enabled** - Enabling this will configure containerd to use management cluster's Zot registry service. To make use of it as a pull-through cache, you also have to specify registries to cache images for.|**Type:** `boolean`<br/>**Default:** `true`|
| `global.components.containerd.managementClusterRegistryCache.mirroredRegistries` | **Registries to cache** - Here you must specify each registry to cache container images for. Please also make sure to have an entry for each registry in Global > Components > Containerd > Container registries.|**Type:** `array`<br/>**Default:** `[]`|
| `global.components.containerd.managementClusterRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `string`<br/>|

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

### Connectivity
Properties within the `.global.connectivity` object
Configurations related to cluster connectivity such as container registries.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
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
| `global.connectivity.localRegistryCache` | **Local registry cache** - Caching container registry within the cluster.|**Type:** `object`<br/>|
| `global.connectivity.localRegistryCache.enabled` | **Enable** - Enabling this will deploy the Zot registry service in the cluster. To make use of it as a pull-through cache, you also have to specify registries to cache images for.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.localRegistryCache.mirroredRegistries` | **Registries to cache** - Here you must specify each registry to cache container images for. Please also make sure to have an entry for each registry in Global > Components > Containerd > Container registries.|**Type:** `array`<br/>**Default:** `[]`|
| `global.connectivity.localRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.localRegistryCache.port` | **Service port** - NodePort used by the local registry service.|**Type:** `integer`<br/>**Default:** `32767`|
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
| `global.connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `object`<br/>|
| `global.connectivity.proxy.enabled` | **Enable**|**Type:** `boolean`<br/>|
| `global.connectivity.proxy.httpProxy` | **HTTP proxy** - HTTP proxy - To be passed to the HTTP_PROXY environment variable in all hosts.|**Type:** `string`<br/>|
| `global.connectivity.proxy.httpsProxy` | **HTTPS proxy** - HTTPS proxy - To be passed to the HTTPS_PROXY environment variable in all hosts.|**Type:** `string`<br/>|
| `global.connectivity.proxy.noProxy` | **No proxy** - No proxy - Comma-separated addresses to be passed to the NO_PROXY environment variable in all hosts.|**Type:** `string`<br/>|

### Control plane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `global.controlPlane.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `global.controlPlane.machineTemplate` | **Template to define control plane nodes**|**Type:** `object`<br/>|
| `global.controlPlane.machineTemplate.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Default:** `"giantswarm"`|
| `global.controlPlane.machineTemplate.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `global.controlPlane.machineTemplate.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>|
| `global.controlPlane.machineTemplate.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>|
| `global.controlPlane.machineTemplate.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>|
| `global.controlPlane.machineTemplate.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>|
| `global.controlPlane.oidc` | **OIDC authentication**|**Type:** `object`<br/>|
| `global.controlPlane.oidc.caPem` | **Certificate authority file** - Path to identity provider's CA certificate in PEM format.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.clientId` | **Client ID** - OIDC client identifier to identify with.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsClaim` | **Groups claim** - Name of the identity token claim bearing the user's group memberships.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsPrefix` | **Groups prefix** - Prefix prepended to groups values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.issuerUrl` | **Issuer URL** - URL of the provider which allows the API server to discover public signing keys, not including any path. Discovery URL without the '/.well-known/openid-configuration' part.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernameClaim` | **Username claim** - Name of the identity token claim bearing the unique user identifier.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernamePrefix` | **Username prefix** - Prefix prepended to username values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.replicas` | **Number of nodes** - Number of control plane instances to create. Must be an odd number.|**Type:** `integer`<br/>**Default:** `1`|

### Metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `string`<br/>|
| `global.metadata.labels` | **Labels** - These labels are added to the Kubernetes resources defining this cluster.|**Type:** `object`<br/>|
| `global.metadata.labels.PATTERN` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-zA-Z0-9/\._-]+$`<br/>**Value pattern:** `^[a-zA-Z0-9\._-]+$`<br/>|
| `global.metadata.name` | **Cluster name**|**Type:** `string`<br/>|
| `global.metadata.organization` | **Organization**|**Type:** `string`<br/>|
| `global.metadata.preventDeletion` | **Prevent cluster deletion**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `string`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.global.nodePools` object
Groups of worker nodes with identical configuration.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>**Default:** `"giantswarm"`|
| `global.nodePools.PATTERN.customNodeLabels` | **Node labels**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints` | **Node taints**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*]` | **Custom node taint**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].effect` | **Node taint effect** - One of NoSchedule, PreferNoSchedule or NoExecute.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].key` | **Node taint key** - Name of the label on a node.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].value` | **Node taint value** - Value of the label identified by the key.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Example:** `3`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.PATTERN.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.worker` | **Default nodePool**|**Type:** `object`<br/>|
| `global.nodePools.worker.catalog` | **Catalog** - Name of the VCD catalog in which the VM template is stored.|**Type:** `string`<br/>**Default:** `"giantswarm"`|
| `global.nodePools.worker.customNodeLabels` | **Node labels**|**Type:** `array`<br/>|
| `global.nodePools.worker.customNodeLabels[*]` | **Custom node label**|**Type:** `string`<br/>**Example:** `"key=value"`<br/>**Value pattern:** `^[A-Za-z0-9-_\./]{1,63}=[A-Za-z0-9-_\.]{0,63}$`<br/>|
| `global.nodePools.worker.customNodeTaints` | **Node taints**|**Type:** `array`<br/>|
| `global.nodePools.worker.customNodeTaints[*]` | **Custom node taint**|**Type:** `object`<br/>|
| `global.nodePools.worker.customNodeTaints[*].effect` | **Node taint effect** - One of NoSchedule, PreferNoSchedule or NoExecute.|**Type:** `string`<br/>|
| `global.nodePools.worker.customNodeTaints[*].key` | **Node taint key** - Name of the label on a node.|**Type:** `string`<br/>|
| `global.nodePools.worker.customNodeTaints[*].value` | **Node taint value** - Value of the label identified by the key.|**Type:** `string`<br/>|
| `global.nodePools.worker.diskSizeGB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `global.nodePools.worker.placementPolicy` | **VM placement policy** - Name of the VCD VM placement policy to use.|**Type:** `string`<br/>|
| `global.nodePools.worker.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Example:** `3`<br/>|
| `global.nodePools.worker.sizingPolicy` | **Sizing policy** - Name of the VCD sizing policy to use.|**Type:** `string`<br/>**Example:** `"m1.medium"`<br/>|
| `global.nodePools.worker.storageProfile` | **Storage profile** - Name of the VCD storage profile to use.|**Type:** `string`<br/>|
| `global.nodePools.worker.template` | **Template** - Name of the template used to create the node VMs.|**Type:** `string`<br/>|

### Other global

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.managementCluster` | **Management cluster** - Name of the Cluster API cluster managing this workload cluster.|**Type:** `string`<br/>|

### Pod Security Standards
Properties within the `.global.podSecurityStandards` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.podSecurityStandards.enforced` | **Enforced Pod Security Standards** - Use PSSs instead of PSPs.|**Type:** `boolean`<br/>**Default:** `true`|

### Release
Properties within the `.global.release` object
Information about the workload cluster release.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.release.version` | **Version**|**Type:** `string`<br/>|

### VMware Cloud Director (VCD) settings
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.cloudProviderInterface` | **Cloud provider interface (CPI)**|**Type:** `object`<br/>|
| `global.providerSpecific.cloudProviderInterface.enableVirtualServiceSharedIP` | **Share IPs in virtual services** - If enabled, multiple virtual services can share the same virtual IP address.|**Type:** `boolean`<br/>**Default:** `true`|
| `global.providerSpecific.cloudProviderInterface.oneArm` | **One-arm** - If enabled, use an internal IP for the virtual service with a NAT rule to expose the external IP. Otherwise the virtual service will be exposed directly with the external IP.|**Type:** `object`<br/>|
| `global.providerSpecific.cloudProviderInterface.oneArm.enabled` | **Enable**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.providerSpecific.containerStorageInterface` | **Container storage interface (CSI)**|**Type:** `object`<br/>|
| `global.providerSpecific.containerStorageInterface.storageClass` | **Pre-create storage class** - Pre-create storage class for the VCD CSI.|**Type:** `object`<br/>|
| `global.providerSpecific.containerStorageInterface.storageClass.delete` | **Pre-create delete storage class**|**Type:** `object`<br/>|
| `global.providerSpecific.containerStorageInterface.storageClass.delete.isDefault` | **Default storage class**|**Type:** `boolean`<br/>**Default:** `true`|
| `global.providerSpecific.containerStorageInterface.storageClass.delete.vcdStorageProfileName` | **Name of storage profile in VCD**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.containerStorageInterface.storageClass.enabled` | **Enable**|**Type:** `boolean`<br/>**Default:** `true`|
| `global.providerSpecific.containerStorageInterface.storageClass.retain` | **Pre-create retain storage class**|**Type:** `object`<br/>|
| `global.providerSpecific.containerStorageInterface.storageClass.retain.isDefault` | **Default storage class**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.providerSpecific.containerStorageInterface.storageClass.retain.vcdStorageProfileName` | **Name of storage profile in VCD**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.org` | **Organization** - VCD organization name.|**Type:** `string`<br/>|
| `global.providerSpecific.ovdc` | **OvDC name** - Name of the organization virtual datacenter (OvDC) to create this cluster in.|**Type:** `string`<br/>|
| `global.providerSpecific.ovdcNetwork` | **OvDC network** - VCD network to connect VMs.|**Type:** `string`<br/>|
| `global.providerSpecific.site` | **Endpoint** - VCD endpoint URL in the format https://VCD_HOST, without trailing slash.|**Type:** `string`<br/>|
| `global.providerSpecific.userContext` | **VCD API access token**|**Type:** `object`<br/>|
| `global.providerSpecific.userContext.secretRef` | **Secret reference**|**Type:** `object`<br/>|
| `global.providerSpecific.userContext.secretRef.secretName` | **Name** - Name of the secret containing the VCD API token.|**Type:** `string`<br/>|
| `global.providerSpecific.vmBootstrapFormat` | **Ignition or cloud-init for OS initialization** - Select either 'ignition' for Flatcar or 'cloud-config' for other OSes (e.g. Ubuntu).|**Type:** `string`<br/>**Default:** `"ignition"`|
| `global.providerSpecific.vmNamingTemplate` | **VM naming template** - Go template to specify the VM naming convention.|**Type:** `string`<br/>**Example:** `"mytenant-{{ .machine.Name | sha256sum | trunc 7 }}"`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `cluster` | **Cluster** - Helm values for the provider-independent cluster chart.|**Type:** `object`<br/>**Default:** `{"providerIntegration":{"apps":{"capiNodeLabeler":{"enable":true},"certExporter":{"configTemplateName":"cloudDirectorCertExporterHelmValues","enable":true},"certManager":{"configTemplateName":"cloudDirectorCertManagerHelmValues","enable":true},"chartOperatorExtensions":{"enable":true},"cilium":{"configTemplateName":"cloudDirectorCiliumHelmValues","enable":true},"ciliumServiceMonitors":{"enable":true},"coreDns":{"enable":true},"coreDnsExtensions":{"enable":true},"etcdDefrag":{"enable":true},"etcdKubernetesResourcesCountExporter":{"enable":true},"k8sDnsNodeCache":{"enable":true},"metricsServer":{"enable":true},"netExporter":{"enable":true},"networkPolicies":{"configTemplateName":"cloudDirectorNetworkPoliciesHelmValues","enable":true},"nodeExporter":{"configTemplateName":"cloudDirectorNodeExporterHelmValues","enable":true},"observabilityBundle":{"enable":true},"observabilityPolicies":{"enable":true},"securityBundle":{"enable":true},"teleportKubeAgent":{"enable":true},"verticalPodAutoscaler":{"enable":true},"verticalPodAutoscalerCrd":{"enable":true}},"controlPlane":{"resources":{"infrastructureMachineTemplate":{"group":"infrastructure.cluster.x-k8s.io","kind":"VCDMachineTemplate","version":"v1beta2"},"infrastructureMachineTemplateSpecTemplateName":"controlplane-vcdmachinetemplate-spec"}},"environmentVariables":{"hostName":"COREOS_CUSTOM_HOSTNAME","ipv4":"COREOS_CUSTOM_IPV4"},"kubeadmConfig":{"enableGiantswarmUser":true,"files":[{"contentFrom":{"secret":{"key":"set-hostname.sh","name":"provider-specific-files-1","prependClusterNameAsPrefix":true}},"path":"/opt/bin/set-hostname.sh","permissions":"0755"}],"ignition":{"containerLinuxConfig":{"additionalConfig":{"systemd":{"units":[{"contents":{"after":["network-online.target"],"install":{"wantedBy":["multi-user.target"]},"requires":["network-online.target"],"service":{"execStart":["/usr/bin/bash -cv 'echo \"$(\"$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2\u003e/dev/null | head -n 1)\" --cmd \"info-get guestinfo.ignition.network\")\" \u003e /opt/bin/set-networkd-units.sh'","/usr/bin/bash -cv 'chmod u+x /opt/bin/set-networkd-units.sh'","/opt/bin/set-networkd-units.sh"],"remainAfterExit":"yes","type":"oneshot"},"unit":{"description":"Install the systemd-networkd interface configuration."}},"enabled":true,"name":"set-networkd-units.service"},{"contents":{"install":{"wantedBy":["multi-user.target"]},"service":{"additionalFields":"{{- if $.global.connectivity.network.staticRoutes -}}\nExecStart=/usr/bin/bash -cv 'sleep 3'\n{{- range $.global.connectivity.network.staticRoutes }}\nExecStart=/usr/bin/bash -cv 'ip route add {{ .destination }} via {{ .via }}'\n{{- end }}\n{{- else -}}\nExecStart=/usr/bin/bash -cv 'echo \"No static routes provided, exiting.\"'\n{{- end -}}","remainAfterExit":"yes","type":"oneshot"},"unit":{"after":["set-networkd-units.service","systemd-networkd.service"],"bindsTo":"systemd-networkd.service","description":"Add static network routes."}},"enabled":true,"name":"static-routes.service"},{"contents":{"install":{"wantedBy":["multi-user.target"]},"service":{"environment":["OUTPUT=/run/metadata/coreos"],"execStart":["/usr/bin/mkdir --parent /run/metadata","/usr/bin/bash -cv 'echo \"COREOS_CUSTOM_HOSTNAME=$(\"$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2\u003e/dev/null | head -n 1)\" --cmd \"info-get guestinfo.ignition.vmname\")\" \u003e ${OUTPUT}'","/usr/bin/bash -cv 'echo \"COREOS_CUSTOM_IPV4=$(ip -4 addr show ens192 | awk \\'/inet / {print $2}\\' | cut -d \\'/\\' -f1)\" \u003e\u003e ${OUTPUT}'"],"remainAfterExit":"yes","restart":"on-failure","type":"oneshot"},"unit":{"after":["set-networkd-units.service"],"description":"Provides CoreOS metadata for dependent services."}},"enabled":true,"name":"coreos-metadata.service"},{"contents":{"install":{"wantedBy":["multi-user.target"]},"service":{"environmentFile":["/run/metadata/coreos"],"execStart":["/opt/bin/set-hostname.sh"],"remainAfterExit":"yes","type":"oneshot"},"unit":{"after":["coreos-metadata.service"],"before":["teleport.service"],"description":"Set machine hostname","requires":["coreos-metadata.service"]}},"enabled":true,"name":"set-hostname.service"},{"contents":{"install":{"wantedBy":["default.target"]},"service":{"execStart":["/usr/sbin/ethtool -K ens192 tx-udp_tnl-csum-segmentation off","/usr/sbin/ethtool -K ens192 tx-udp_tnl-segmentation off"],"remainAfterExit":"yes","type":"oneshot"},"unit":{"after":["network.target"],"description":"Disable TCP segmentation offloading"}},"enabled":true,"name":"ethtool-segmentation.service"},{"dropins":[{"contents":"[Unit]\nUpholds=static-routes.service","name":"10-static-routes-dependency.conf"}],"enabled":true,"name":"systemd-networkd.service"},{"contents":{"install":{"wantedBy":["multi-user.target"]},"service":{"additionalFields":"{{- if $.global.connectivity.network.hostEntries -}}\n# Helm templating is a nightmare\n{{- range $.global.connectivity.network.hostEntries }}\nExecStart=/usr/bin/bash -cv 'echo {{ .ip }} {{ .fqdn }} \u003e\u003e /etc/hosts'\n{{- end }}\n{{- else -}}\nExecStart=/usr/bin/bash -cv 'echo \"No host entries provided, exiting.\"'\n{{- end -}}","remainAfterExit":"yes","type":"oneshot"},"unit":{"after":["set-hostname.service"],"description":"Add /etc/hosts entries.","requires":["set-hostname.service"]}},"enabled":true,"name":"etc-hosts-entries.service"}]}}}},"postKubeadmCommands":["usermod -aG root nobody"]},"provider":"cloud-director","resourcesApi":{"bastionResourceEnabled":false,"cleanupHelmReleaseResourcesEnabled":true,"helmRepositoryResourcesEnabled":true,"infrastructureCluster":{"group":"infrastructure.cluster.x-k8s.io","kind":"VCDCluster","version":"v1beta2"},"infrastructureMachinePool":{"group":"infrastructure.cluster.x-k8s.io","kind":"VCDMachineTemplate","version":"v1beta2"},"machineHealthCheckResourceEnabled":false,"nodePoolKind":"MachineDeployment"},"useReleases":true,"workers":{"defaultNodePools":{"def00":{"catalog":"giantswarm","diskSize":"30","replicas":2,"sizingPolicy":"m1.large"}},"resources":{"infrastructureMachineTemplateSpecTemplateName":"worker-vcdmachinetemplate-spec"}}}}`|
| `cluster-shared` | **Library chart**|**Type:** `object`<br/>|
| `managementCluster` | **Management cluster name** - The Cluster API management cluster that manages this cluster.|**Type:** `string`<br/>|
| `provider` | **Cluster API provider name**|**Type:** `string`<br/>|



<!-- DOCS_END -->
