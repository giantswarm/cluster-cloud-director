{{- define "ignitionSpec" -}}
format: ignition
ignition:
  containerLinuxConfig:
    additionalConfig: |-
      storage:
        files:
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
            ExecStart=/usr/bin/bash -cv 'echo "COREOS_CUSTOM_HOSTNAME=testxa" > ${OUTPUT}'
        - name: set-hostname.service
          enabled: true
          contents: |
            [Unit]
            Description=Set the hostname for this machine
            Requires=coreos-metadata.service
            After=coreos-metadata.service
            [Service]
            Type=oneshot
            RemainAfterExit=yes
            EnvironmentFile=/run/metadata/coreos
            ExecStart=/opt/set-hostname
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
              After=coreos-metadata.service
              [Service]
              # Make metadata environment variables available for pre-kubeadm commands.
              EnvironmentFile=/run/metadata/*
{{- end -}}