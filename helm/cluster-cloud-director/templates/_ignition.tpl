{{- define "ignitionStaticRoutesCommands" -}}
{{- range $.Values.connectivity.network.staticRoutes}}
TIMEOUT=10
echo "Trying to add route to {{ .destination }} - Timeout 5 seconds."
while [[ ! $(ip r | grep {{ .destination }}) && $TIMEOUT -gt 0 ]]
do
  sleep 0.5
  sudo ip route add {{ .destination }} via {{ .via }}
  ((TIMEOUT-=1))
done
if [[ ! $(ip r | grep {{ .destination }}) ]]
then
  echo "WARN - Timed out while waiting for network with Gateway {{ .destination }} to come online."
fi
{{- end -}}
{{- end }}

{{- define "ignitionSpec" -}}
format: ignition
ignition:
  containerLinuxConfig:
    additionalConfig: |-
      storage:
        files:
        {{- include "ntpIgnition" . | nindent 8 }}
        - path: /opt/set-hostname
          filesystem: root
          mode: 0744
          contents:
            inline: |
              #!/bin/sh
              set -x
              echo "${COREOS_CUSTOM_HOSTNAME}" > /etc/hostname
              hostname "${COREOS_CUSTOM_HOSTNAME}"
              echo "::1         ipv6-localhost ipv6-loopback" >/etc/hosts
              echo "127.0.0.1   localhost" >>/etc/hosts
              echo "127.0.0.1   ${COREOS_CUSTOM_HOSTNAME}" >>/etc/hosts
              sudo systemctl restart systemd-networkd
        - path: /opt/set-static-routes
          filesystem: root
          mode: 0744
          contents:
            inline: |
              #!/bin/sh
              set -x
              {{- include "ignitionStaticRoutesCommands" . | nindent 14}}
      systemd:
        units:
        - name: coreos-metadata.service
          contents: |
            [Unit]
            Description=VMware metadata agent
            After=nss-lookup.target
            After=network-online.target
            Wants=network-online.target
            [Service]
            Type=oneshot
            Restart=on-failure
            RemainAfterExit=yes
            Environment=OUTPUT=/run/metadata/coreos
            ExecStart=/usr/bin/mkdir --parent /run/metadata
            ExecStart=/usr/bin/bash -cv 'echo "COREOS_CUSTOM_HOSTNAME=$(/usr/share/oem/bin/vmtoolsd --cmd "info-get guestinfo.ignition.vmname")" > ${OUTPUT}'
            Environment=NETUNITFILE=/opt/set-networkd-units
            ExecStart=/usr/bin/bash -cv 'echo "$(/usr/share/oem/bin/vmtoolsd --cmd "info-get guestinfo.ignition.network")" > ${NETUNITFILE}'
            ExecStart=/usr/bin/bash -cv 'chmod u+x ${NETUNITFILE}'
        - name: set-hostname.service
          enabled: true
          contents: |
            [Unit]
            Description=Set the hostname
            Requires=coreos-metadata.service
            After=coreos-metadata.service
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            EnvironmentFile=/run/metadata/coreos
            ExecStart=/opt/set-hostname
            [Install]
            WantedBy=multi-user.target
        - name: set-networkd-units.service
          enabled: true
          contents: |
            [Unit]
            Description=Install the networkd unit files
            Requires=coreos-metadata.service
            After=set-hostname.service
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            ExecStart=/opt/set-networkd-units
            [Install]
            WantedBy=multi-user.target
        - name: set-static-routes.service
          enabled: true
          contents: |
            [Unit]
            Description=Install the static routes
            Requires=coreos-metadata.service
            After=set-networkd-units.service
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            ExecStart=/opt/set-static-routes
            [Install]
            WantedBy=multi-user.target
        - name: ethtool-segmentation.service
          enabled: true
          contents: |
            [Unit]
            After=network.target
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            ExecStart=/usr/sbin/ethtool -K ens192 tx-udp_tnl-csum-segmentation off
            ExecStart=/usr/sbin/ethtool -K ens192 tx-udp_tnl-segmentation off
            [Install]
            WantedBy=default.target
        - name: kubeadm.service
          enabled: true
          dropins:
          - name: 10-flatcar.conf
            contents: |
              [Unit]
              # kubeadm must run after coreos-metadata populated /run/metadata directory.
              Requires=coreos-metadata.service
              After=set-static-routes.service
              [Service]
              # Make metadata environment variables available for pre-kubeadm commands.
              EnvironmentFile=/run/metadata/*
{{- end -}}