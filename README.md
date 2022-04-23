# README.md

<img align="left" width="144px" height="144px" src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67"/>

## My home Kubernetes cluster :sailboat:

... managed with Flux and Renovate :robot:

<br/>
<br/>
<br/>

[![k3s](https://img.shields.io/badge/k3s-v1.23.5-orange?style=for-the-badge)](https://k3s.io/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)

## Bootstrap Flux

```bash
flux bootstrap github \
  --version=latest \
  --owner=j0sh3rs \
  --repository=k3s-at-home \
  --path=cluster \
  --personal \
  --network-policy=false
```

## SOPS secret from GPG key

```bash
gpg \
  --export-secret-keys \
  --armor <GPG_KEY_ID> | \
  kubectl create secret generic sops-gpg \
  --namespace=flux-system \
  --from-file=sops.asc=/dev/stdin
```

## Encrypt kubernetes resources with sops binary

```bash
sops \
  --encrypt \
  --pgp=<GPG_KEY_ID> \
  --encrypted-regex '^(data|stringData)$' \
  --in-place <FILE_PATH>
```

## Install pre-commit hooks

```bash
pre-commit install
```
