#!/usr/bin/env bash

ip link delete cilium_host
ip link delete cilium_net
ip link delete cilium_vxlan
iptables-save | grep -iv cilium | iptables-restore
ip6tables-save | grep -iv cilium | ip6tables-restore

k3s-uninstall.sh 
rm -rf /var/lib/rancher /etc/rancher /var/lib/longhorn /etc/cni/ /opt/cni /var/lib/cni