#!/usr/bin/env bash
set -x
## Vars for Behavior Pivots
BOOTSTRAP_MASTER_NODE="bee-jms-03"
MY_HOST=$(hostname)

### Setup Kernel

function set_kernel_tunings () {
    cat <<-EOHD > /etc/sysctl.conf
fs.file-max = 1048576
fs.inotify.max_queued_events = 16384
fs.inotify.max_user_instances = 512
fs.inotify.max_user_watches = 1048576
fs.suid_dumpable=0
kernel.core_pattern=|/bin/false
kernel.keys.root_maxbytes=25000000
kernel.panic=10
kernel.panic_on_oops=1
net.core.bpf_jit_enable=1
net.core.netdev_max_backlog=65535
net.core.somaxconn=65535
net.ipv4.ip_forward = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_fastopen=3
net.ipv4.tcp_max_syn_backlog=65535
net.ipv4.tcp_max_tw_buckets=262144
net.ipv4.tcp_mtu_probing=1
vm.max_map_count = 262144
vm.overcommit_memory=1
vm.panic_on_oom=0
EOHD
sysctl -p
}
### Setup Packages

function install_cilium_cli () {
    CILIUM_CLI_VERSION="v0.15.13"
    CLI_ARCH=amd64
    if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
    curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
    sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
    sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
    rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
}

function install_flux_cli () {
    curl -s https://fluxcd.io/install.sh | sudo bash
}

function install_k3s_initial () {
    mkdir -p /var/lib/rancher/k3s/server
    cat <<-EOHD > /var/lib/rancher/k3s/server/audit.yaml
---
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
EOHD

    curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -s - --token FofgJxtCfMK4AgQ4HCsvBUP9z8cwCCs9NKeRzpsarWPPh66fDwswJZcrp3kXAdUSTmAvbvwXhxdCumsCPyxuTw2xE98q62ZdX9T4brfjJ9SDYgFgczmWBiCDkuKmL9Zy \
    --disable traefik \
    --disable metrics-server \
    --disable servicelb \
    --disable local-storage \
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
    --etcd-expose-metrics \
    --etcd-s3 \
    --etcd-s3-endpoint https://s3.68cc.io \
    --etcd-s3-access-key k3s \
    --etcd-s3-secret-key k3s12345 \
    --etcd-s3-bucket k8s \
    --etcd-s3-folder backups/etcd \
    --cluster-init \
    --disable-kube-proxy \
    --flannel-backend=none \
    --disable-network-policy
}

function install_k3s_secondary () {
  mkdir -p /var/lib/rancher/k3s/server
  cat <<-EOHD > /var/lib/rancher/k3s/server/audit.yaml
---
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
EOHD

  curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -s - --server https://192.168.35.10:6443 --token FofgJxtCfMK4AgQ4HCsvBUP9z8cwCCs9NKeRzpsarWPPh66fDwswJZcrp3kXAdUSTmAvbvwXhxdCumsCPyxuTw2xE98q62ZdX9T4brfjJ9SDYgFgczmWBiCDkuKmL9Zy \
  --disable traefik \
  --disable metrics-server \
  --disable servicelb \
  --disable local-storage \
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
  --etcd-expose-metrics \
  --etcd-s3 \
  --etcd-s3-endpoint https://s3.68cc.io \
  --etcd-s3-access-key k3s \
  --etcd-s3-secret-key k3s12345 \
  --etcd-s3-bucket k8s \
  --etcd-s3-folder backups/etcd \
  --disable-kube-proxy \
  --flannel-backend=none \
  --disable-network-policy
}

function bootstrap_flux () {
    kubectl create ns flux-system
    cat /home/j0sh3rs/.config/sops/age/keys.txt | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin
    flux bootstrap github \
        --owner=j0sh3rs \
        --repository=k3s-at-home \
        --path=bootstrap \
        --personal \
        --network-policy=false
}

function bootstrap_cilium () {
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
  cilium install --version 1.14.4 --helm-values cilium/bootstrap-helm-values.yaml
}
## Run on everything
# set_kernel_tunings
install_cilium_cli
install_flux_cli
if [ "$MY_HOST" == "$BOOTSTRAP_MASTER_NODE" ]; then
  install_k3s_initial
  sleep 5
  bootstrap_cilium
  bootstrap_flux
else
  install_k3s_secondary
fi
