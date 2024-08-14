#!/bin/bash
tanzu plugin list | tail -n +2 | sort |  cut -c3-22,102-134 | grep "\S" | grep -v login  | tr -s ' ' > /tmp/installed
tanzu plugin search | tail -n +2 | sort  |  cut -c3-22,102-140  | sort | grep "\S" | tr -s ' ' > /tmp/allversions
#
#
export f1=''
l1="----------------------------------------------------------------------------------------"
echo $l1
cat /tmp/installed | awk '{ print $1" "$2}' | sort | tr ' ' '_' > /tmp/installedv2
for f in `cat /tmp/installedv2`
do
  f=`echo $f | tr '_' ' '` # get ridd of the underscore
  f1=`grep "^$f" /tmp/allversions`
  f2=`grep "^$f" /tmp/installed`
  if [ -n "$f1" ]
        then
        f11=`echo "$f1" | awk '{ print $3 }'`
        f21=`echo "$f2" | awk '{ print $3 }'`
        if [ "$f11" != "$f21" ]
        then
          printf "%-40s upgradable to --> %-40s\n" "$f2" "$f1"
          # tanzu plugin upgrade  telemetry --target kubernetes
          if [ "$1" == "--upgrade" ]
          then
            p1=`echo $f1 | awk '{ print $1 }'`
            p2=`echo $f1 | awk '{ print $2 }'`
            if [ "$2" == "--test" ]
            then
              echo "tanzu plugin upgrade ""$p1"" --target ""$p2"
            fi
            if [ "$2" == "--yes" ]
            then
              tanzu plugin upgrade "$p1" --target "$p2"
            fi
          fi
        else
          printf "%-40s same version ---> %-40s\n" "$f2" "$f1"
        fi
  fi
  export f1=''
done
echo $l1
