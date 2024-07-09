# Tanzu_App_Engine_Ops


Make sure image exists in harbor.lab.brianragzzi.com/tanzu
update /.tanzu/config/lablinks.yml with correct path

set:
tanzu project use AMER-East
tanzu space use bragazzi-app1


tanzu app init gohostname --build-path . --build-type buildpack
