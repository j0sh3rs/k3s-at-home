#!/usr/bin/env bash

sudo ip link delete cilium_host
sudo ip link delete cilium_net
sudo ip link delete cilium_vxlan
sudo iptables-save | grep -iv cilium | sudo iptables-restore
sudo ip6tables-save | grep -iv cilium | sudo ip6tables-restore

sudo k3s-uninstall.sh
sudo rm -rf /var/lib/rancher /etc/rancher /var/lib/longhorn /etc/cni/ /opt/cni /var/lib/cni
