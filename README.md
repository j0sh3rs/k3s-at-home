# README.md

<img align="left" width="144px" height="144px" src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67"/>

## k3s-at-home

... managed with Flux and Renovate, encrypted with Age :robot:

This repository is shamelessly stolen and modified from the great work that [Auricom](https://github.com/auricom/home-cluster) has done on his homelab.

Modified to my needs, updated to use Age instead of PGP, Calico for the CNI in eBPF mode, and using cloudflared and/or ingress-nginx.

<br/>
<br/>
<br/>

[![k3s](https://img.shields.io/badge/k3s-v1.26.3-green?style=for-the-badge)](https://k3s.io/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)
[![renovate](https://img.shields.io/badge/renovate-enabled-success?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjUgNSAzNzAgMzcwIj48Y2lyY2xlIGN4PSIxODkiIGN5PSIxOTAiIHI9IjE4NCIgZmlsbD0iI2ZlMiIvPjxwYXRoIGZpbGw9IiM4YmIiIGQ9Ik0yNTEgMjU2bC0zOC0zOGExNyAxNyAwIDAxMC0yNGw1Ni01NmMyLTIgMi02IDAtN2wtMjAtMjFhNSA1IDAgMDAtNyAwbC0xMyAxMi05LTggMTMtMTNhMTcgMTcgMCAwMTI0IDBsMjEgMjFjNyA3IDcgMTcgMCAyNGwtNTYgNTdhNSA1IDAgMDAwIDdsMzggMzh6Ii8+PHBhdGggZmlsbD0iI2Q1MSIgZD0iTTMwMCAyODhsLTggOGMtNCA0LTExIDQtMTYgMGwtNDYtNDZjLTUtNS01LTEyIDAtMTZsOC04YzQtNCAxMS00IDE1IDBsNDcgNDdjNCA0IDQgMTEgMCAxNXoiLz48cGF0aCBmaWxsPSIjYjMwIiBkPSJNMjg1IDI1OGw3IDdjNCA0IDQgMTEgMCAxNWwtOCA4Yy00IDQtMTEgNC0xNiAwbC02LTdjNCA1IDExIDUgMTUgMGw4LTdjNC01IDQtMTIgMC0xNnoiLz48cGF0aCBmaWxsPSIjYTMwIiBkPSJNMjkxIDI2NGw4IDhjNCA0IDQgMTEgMCAxNmwtOCA3Yy00IDUtMTEgNS0xNSAwbC05LThjNSA1IDEyIDUgMTYgMGw4LThjNC00IDQtMTEgMC0xNXoiLz48cGF0aCBmaWxsPSIjZTYyIiBkPSJNMjYwIDIzM2wtNC00Yy02LTYtMTctNi0yMyAwLTcgNy03IDE3IDAgMjRsNCA0Yy00LTUtNC0xMSAwLTE2bDgtOGM0LTQgMTEtNCAxNSAweiIvPjxwYXRoIGZpbGw9IiNiNDAiIGQ9Ik0yODQgMzA0Yy00IDAtOC0xLTExLTRsLTQ3LTQ3Yy02LTYtNi0xNiAwLTIybDgtOGM2LTYgMTYtNiAyMiAwbDQ3IDQ2YzYgNyA2IDE3IDAgMjNsLTggOGMtMyAzLTcgNC0xMSA0em0tMzktNzZjLTEgMC0zIDAtNCAybC04IDdjLTIgMy0yIDcgMCA5bDQ3IDQ3YTYgNiAwIDAwOSAwbDctOGMzLTIgMy02IDAtOWwtNDYtNDZjLTItMi0zLTItNS0yeiIvPjxwYXRoIGZpbGw9IiMxY2MiIGQ9Ik0xNTIgMTEzbDE4LTE4IDE4IDE4LTE4IDE4em0xLTM1bDE4LTE4IDE4IDE4LTE4IDE4em0tOTAgODlsMTgtMTggMTggMTgtMTggMTh6bTM1LTM2bDE4LTE4IDE4IDE4LTE4IDE4eiIvPjxwYXRoIGZpbGw9IiMxZGQiIGQ9Ik0xMzQgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em0tMzUgMzZsMTgtMTggMTggMTgtMTggMTh6Ii8+PHBhdGggZmlsbD0iIzJiYiIgZD0iTTExNiAxNDlsMTgtMTggMTggMTgtMTggMTh6bTU0LTU0bDE4LTE4IDE4IDE4LTE4IDE4em0tODkgOTBsMTgtMTggMTggMTgtMTggMTh6bTEzOS04NWwyMyAyM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTI0LTI0Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS01IDEyLTUgMTYgMHoiLz48cGF0aCBmaWxsPSIjM2VlIiBkPSJNMTM0IDk1bDE4LTE4IDE4IDE4LTE4IDE4em0tNTQgMThsMTgtMTcgMTggMTctMTggMTh6bTU1LTUzbDE4LTE4IDE4IDE4LTE4IDE4em05MyA0OGwtOC04Yy00LTUtMTEtNS0xNiAwTDEwMyAyMDFjLTQgNC00IDExIDAgMTVsOCA4Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS00IDEyLTQgMTYgMHoiLz48cGF0aCBmaWxsPSIjOWVlIiBkPSJNMjcgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em01NC01M2wxOC0xOCAxOCAxOC0xOCAxOHoiLz48cGF0aCBmaWxsPSIjMGFhIiBkPSJNMjMwIDExMGwxMyAxM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTEzLTEzYzQgNCAxMSA0IDE1IDBsMTAxLTEwMWM1LTUgNS0xMSAwLTE2eiIvPjxwYXRoIGZpbGw9IiMxYWIiIGQ9Ik0xMzQgMjQ4Yy00IDAtOC0yLTExLTVsLTIzLTIzYTE2IDE2IDAgMDEwLTIzTDIwMSA5NmExNiAxNiAwIDAxMjIgMGwyNCAyNGM2IDYgNiAxNiAwIDIyTDE0NiAyNDNjLTMgMy03IDUtMTIgNXptNzgtMTQ3bC00IDItMTAxIDEwMWE2IDYgMCAwMDAgOWwyMyAyM2E2IDYgMCAwMDkgMGwxMDEtMTAxYTYgNiAwIDAwMC05bC0yNC0yMy00LTJ6Ii8+PC9zdmc+)](https://github.com/renovatebot/renovate)

## Bootstrap Flux

```shell
kubectl create ns flux-system # Seed the namespace

cat age.agekey | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin # Add the sops key

curl -s https://fluxcd.io/install.sh | sudo bash # ensure flux is latest on host

flux bootstrap github \
  --version=latest \
  --owner=j0sh3rs \
  --repository=k3s-at-home \
  --path=bootstrap \
  --personal \
  --network-policy=false

flux bootstrap github \
  --version=latest \
  --owner=j0sh3rs \
  --repository=k3s-at-home \
  --path=cluster \
  --personal \
  --network-policy=false
```

## Install pre-commit hooks

```shell
pre-commit install
```

## Installing K3s

K3s allows you to use either a config file or CLI args + Envvars to customize its installation. I've opted for the CLI args + Envvars, and may consider switching to the config file at a later date.

My installation command looks roughly like such, incorporating as much of the [k3s cis hardening guide](https://docs.k3s.io/security/hardening-guide) as possible.

```shell
mkdir -p /var/lib/rancher/k3s/server
cat <<-EOHD > /var/lib/rancher/k3s/server/audit.yaml
---
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
EOHD
# cat <<-EOHD > /var/lib/rancher/k3s/server/psa.yaml
# ---
# apiVersion: apiserver.config.k8s.io/v1
# kind: AdmissionConfiguration
# plugins:
# - name: PodSecurity
#   configuration:
#     apiVersion: pod-security.admission.config.k8s.io/v1beta1
#     kind: PodSecurityConfiguration
#     defaults:
#       enforce: "restricted"
#       enforce-version: "latest"
#       audit: "restricted"
#       audit-version: "latest"
#       warn: "restricted"
#       warn-version: "latest"
#     exemptions:
#       usernames: []
#       runtimeClasses: []
#       namespaces: [kube-system, infra]
# EOHD
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -s - --token ${MYTOKEN} \
--disable local-storage \
--disable traefik \
--disable metrics-server \
--disable servicelb \
--disable-cloud-controller \
--protect-kernel-defaults=true \
--write-kubeconfig-mode 0644 \
--kube-proxy-arg=metrics-bind-address=0.0.0.0 \
--kube-scheduler-arg=bind-address=0.0.0.0 \
--kube-apiserver-arg=audit-log-path=/var/log/k3s/server/audit.log \
--kube-apiserver-arg=audit-policy-file=/var/lib/rancher/k3s/server/audit.yaml \
--kube-apiserver-arg=audit-log-maxage=7 \
--kube-apiserver-arg=audit-log-maxbackup=3 \
--kube-apiserver-arg=audit-log-maxsize=50 \
--kube-apiserver-arg=request-timeout=300s \
--kube-apiserver-arg=service-account-lookup=true \
--kube-controller-manager-arg=terminated-pod-gc-threshold=10 \
--kube-controller-manager-arg=use-service-account-credentials=true \
--kube-controller-manager-arg=bind-address=0.0.0.0 \
--kubelet-arg=streaming-connection-idle-timeout=5m \
--kubelet-arg=make-iptables-util-chains=true \
--kubelet-arg=containerd=/run/k3s/containerd/containerd.sock \
--secrets-encryption \
# --flannel-backend=none \
# --cluster-cidr=172.16.0.0/16 \
# --disable-network-policy \
```

For agents, the following was used to connect them:

```shell
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest K3S_URL=https://${NODE}:6443 K3S_TOKEN=${MY_TOKEN} sh -s - --protect-kernel-defaults=true --kube-proxy-arg=metrics-bind-address=0.0.0.0 --kubelet-arg=streaming-connection-idle-timeout=5m --kubelet-arg=make-iptables-util-chains=true --kubelet-arg=containerd=/run/k3s/containerd/containerd.sock
```

## OS Tuning

All agents and nodes are augmented with the following kernel tunings:

```shell
fs.inotify.max_user_watches = 1048576
fs.inotify.max_user_instances = 512
fs.inotify.max_queued_events = 16384
vm.max_map_count = 262144
fs.file-max = 1048576
net.ipv4.ip_forward = 1
fs.suid_dumpable=0
kernel.core_pattern=|/bin/false
vm.panic_on_oom=0
vm.overcommit_memory=1
kernel.panic=10
kernel.panic_on_oops=1
kernel.keys.root_maxbytes=25000000
net.core.somaxconn=65535
net.ipv4.tcp_max_syn_backlog=65535
net.core.netdev_max_backlog=65535
net.ipv4.tcp_max_tw_buckets=262144
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_fastopen=3
net.ipv4.tcp_mtu_probing=1
```

Further, since the nodes are not exposed to the internet, the following GRUB boot configs have been implemented:

```shell
mitigations=off elevator=mq-deadline transparent_hugepage=always
```

## Roadmap

- [ ] Re-implement kured and system-upgrade controller
- [ ] Move to Calico w/ eBPF for fun
- [ ] Figure out better bootstrapping order
  - [ ] Conflicts between initial run of flux + CRDs + Prom Monitors + Ingresses
- [ ] Upstream improvements to helm charts as outputs of security tool analysis
  - [ ] Popeye
  - [ ] Kube-Bench
  - [ ] Polaris
