#! /usr/bin/env bash

optslist=":r:n:c:N:"

while getopts "${optslist}" flag; do
    case "${flag}" in
        r) repo_url=${OPTARG};;
        n) namespace=${OPTARG};;
        c) chart_name=${OPTARG};;
        N) repo_name=${OPTARG};;
        ?) echo "Bad option passed. Try again"
    esac
done

helm_release_heredoc=$(cat <<- EOHD
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: ${chart_name}
  namespace: ${namespace}
spec:
  interval: 5m
  chart:
    spec:
      # renovate: registryUrl=${repo_url}
      chart: ${chart_name}
      version:
      sourceRef:
        kind: HelmRepository
        name: ${repo_name}
        namespace: flux-system
      interval: 5m
  values:
EOHD
)

chart_repo_heredoc=$(cat <<- EOHD
---
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: ${repo_name}
  namespace: flux-system
spec:
  interval: 1h
  url: ${repo_url}
  timeout: 3m
EOHD
)

kustomization_heredoc=$(cat <<- EOHD
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - helm-release.yaml
EOHD
)

echo "${chart_repo_heredoc}" | tee ./cluster/base-custom/charts/"${repo_name}".yaml
mkdir -p ./cluster/"${namespace}/${chart_name}"
echo "${helm_release_heredoc}" | tee ./cluster/"${namespace}/${chart_name}"/helm-release.yaml > /dev/null 2>&1
echo "${kustomization_heredoc}" | tee ./cluster/"${namespace}/${chart_name}"/kustomization.yaml > /dev/null 2>&1
