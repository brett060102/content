#!/bin/bash
OUT=/tmp/console-notification.yml

cat <<EOF >$OUT
apiVersion: console.openshift.io/v1
kind: ConsoleNotification
metadata:
 name: classification-banner
spec:
 text: Unclassified ##Classification Level
 location: BannerTopBottom ##Other options are BannerBottom, BannerTopBottom
 color: '#FFFFFF' ##Hexcode for white text color
 backgroundColor: '#008000' ##Hexcode for banner background color
EOF

oc apply -f $OUT
while true; do 
    status=$(oc get consolenotification classification-banner -o=jsonpath='{.spec.text}')
    if [ "$status" == "Unclassified" ]; then
        exit 0
    fi
    sleep 5
done