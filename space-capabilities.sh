source tanzucli.src
export KUBECONFIG="$HOME/.config/tanzu/kube/config"
export proj="AMER-East"
export sp="bragazzi-helm1"
export org="sa-tanzu-platform"
export cl="bragazzi-cl1"
export cg="bragazzi-cg1"
export w=''
#export w='--wide'
export line="-----------------------------------------------------------------"
#yes | tanzu context delete $org
#source ./tanzucli.src
tanzu login
tanzu project use $proj
tanzu operations clustergroup use  $cg
echo $line > /tmp/clustergroup.txt
echo "Cluster Group Capabilities" >>  /tmp/clustergroup.txt
echo $line >> /tmp/clustergroup.txt
#kubectl get kubernetescluster $cl -o yaml | grep -A 1000 capabilities: | grep name: | awk '{ print $2 }' | sort >> /tmp/clustergroup.txt
kubectl get packageinstalls >> /tmp/clustergroup.txt
tanzu space use $sp
echo $line > /tmp/space.txt
echo "Space Capabilities" >>  /tmp/space.txt
echo $line >> /tmp/space.txt
tanzu space get $sp| grep  -e '^   -' | awk '{ print $2 }' | sort >> /tmp/space.txt
sdiff /tmp/clustergroup.txt /tmp/space.txt
tanzu space get $sp  | grep -A 10 Profiles | grep -B 10 Availability | grep -v Availability | grep -v Profiles | sed  '/^$/d' | awk '{ print $1}' > /tmp/prof.txt
for f in `cat /tmp/prof.txt`
do
echo $line
echo $f
echo $line
tanzu profile get $f | grep -A 100 Capabilities
done
