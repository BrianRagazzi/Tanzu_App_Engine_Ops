# Tanzu_App_Engine_Ops

## Links
https://github.com/Tanzu-Solutions-Engineering/tanzu-platform-workshop/
https://github.com/timosalm/tp-gitops-install-emea
https://www.vcluster.com/
https://github.com/tanzu-end-to-end/e2e-tap-gitops

https://github.com/Tanzu-Solutions-Engineering/tanzu-platform-workshop/blob/main/lab-platform-engineer/01-full-lab.md


Make sure image exists in harbor.lab.brianragzzi.com/tanzu
update /.tanzu/config/lablinks.yml with correct path

install tanzu cli


use this kubeconfig get interact with UCO through kubectl:
"$HOME/.config/tanzu/kube/config"
kubectl --kubeconfig="$HOME/.config/tanzu/kube/config" get mns -A


set:
tanzu project use AMER-East
tanzu space use bragazzi-app1


## INstall tanzu cli plugins:

tanzu login
tanzu plugin install --group vmware-tanzu/platform-engineer
tanzu plugin install --group vmware-tanzu/app-developer

## update plugin version:
```
tanzu-cli-ver.sh --upgrade --test
```

```
tanzu-cli-ver.sh --upgrade --yes
```



tanzu app init gohostname --build-path . --build-type buildpack


tanzu build config --build-plan-source-type=ucp --containerapp-registry harbor.lab.brianragazzi.com/tanzu/{name}



kubectl get pods -A  -o custom-columns='NAMESPACE:.metadata.namespace, NAME:.metadata.name, CPU_REQUEST:.spec.containers[*].resources.requests.cpu, MEMORY_REQUEST:.spec.containers[*].resources.requests.memory'

kubectl get po -A | grep -v Completed | wc -l

## Helm App:
https://docs.vmware.com/en/VMware-Tanzu-Platform/SaaS/create-manage-apps-tanzu-platform-k8s/how-to-helm-charts-in-spaces.html?hWord=N4IghgNiBcIBYFMIFsQF8g


## Requests
1 CP node: 2CPU 8 GB RAM
3 Worker nodes: 4 CPU, 8GB RAM

* - New Cluster, baseline:  3.94 CPUs, 0.79 GB memory
* - Same Cluster, Attach to TP, not AppEngine-Enabled: 5.55 CPUs, 3.83 GB memory
* - Same Cluster, detach from TP, 3.94 CPUs, 0.79 GB memory
* - Same Cluster, reattach to AppEngine-enabled CG with no assigned Capabilities: 5.45 CPUs, 3.76 GB memory
* - Same Cluster, add capabilities
       Cross Cluster,
       Service Binding,
       CertManager,
       ContainerApp,
       observability,
       Gateway API,
       Service Mesh observability,
       Cross Cluster Capability (b0rked)
       Egress,
       mTLS,
       bitnami,
       CrossPlane,
       Service Registry,
       : 7.98 CPUs, 9.13GB memory
