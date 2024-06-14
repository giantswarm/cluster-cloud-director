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
            ExecStart=/usr/bin/bash -cv 'echo "COREOS_CUSTOM_HOSTNAME=$("$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2>/dev/null | head -n 1)" --cmd "info-get guestinfo.ignition.vmname")" > ${OUTPUT}'
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
            Description=Install the networkd unit files and static routes
            Requires=coreos-metadata.service
            After=set-hostname.service
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            ExecStart=/usr/bin/bash -cv 'echo "$("$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2>/dev/null | head -n 1)" --cmd "info-get guestinfo.ignition.network")" > /opt/set-networkd-units'
            {{- if $.Values.global.connectivity.network.staticRoutes }}
            ExecStart=/usr/bin/bash -cv 'echo "sleep 3" >> /opt/set-networkd-units'
            {{- range $.Values.global.connectivity.network.staticRoutes}}
            ExecStart=/usr/bin/bash -cv 'echo "sudo ip route add {{ .destination }} via {{ .via }}" >> /opt/set-networkd-units'
            {{- end }}
            {{- end }}
            ExecStart=/usr/bin/bash -cv 'chmod u+x /opt/set-networkd-units'
            ExecStart=/opt/set-networkd-units
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
        - name: teleport.service
          enabled: true
          contents: |
            [Unit]
            Description=Teleport Service
            After=network.target
            [Service]
            Type=simple
            Restart=on-failure
            ExecStart=/opt/bin/teleport start --roles=node --config=/etc/teleport.yaml --pid-file=/run/teleport.pid
            ExecReload=/bin/kill -HUP $MAINPID
            PIDFile=/run/teleport.pid
            LimitNOFILE=524288
            [Install]
            WantedBy=multi-user.target            
        - name: kubeadm.service
          enabled: true
          dropins:
          - name: 10-flatcar.conf
            contents: |
              [Unit]
              # kubeadm must run after coreos-metadata populated /run/metadata directory.
              Requires=coreos-metadata.service
              After=set-networkd-units.service
              [Service]
              # Make metadata environment variables available for pre-kubeadm commands.
              EnvironmentFile=/run/metadata/*
{{- end -}}