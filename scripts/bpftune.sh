#!/usr/bin/env bash
set -eo pipefail

echo "Install pre-requisites for make"

apt-get install -y libbpf1 libbpf-tools libbpfcc-dev libbpfcc libbpf-dev libcap2 libcap2-bin libcap-dev libnl-3-dev libnl-3-200 clang-17 clang clang-tools-17 clang-tools python3-docutils llvm llvm-17-tools llvm-17 llvm-17-dev libnl-genl-3-dev libnl-genl-3-200 libnl-route-3-200 libnl-route-3-dev make

mkdir -p ~/git/oracle
cd ~/git/oracle
git clone https://github.com/oracle/bpftune.git
cd bpftune
make
make install
systemctl start bpftune
