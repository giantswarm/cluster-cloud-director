#!/bin/sh
set -x
echo "${COREOS_CUSTOM_HOSTNAME}" > /etc/hostname
hostname "${COREOS_CUSTOM_HOSTNAME}"
echo "::1         ipv6-localhost ipv6-loopback" >/etc/hosts
echo "127.0.0.1   localhost" >>/etc/hosts
echo "127.0.0.1   ${COREOS_CUSTOM_HOSTNAME}" >>/etc/hosts
