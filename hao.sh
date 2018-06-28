#!/bin/bash
#Function for nexus upload -- nexus <target> <destination+target name>
export nexus{
export CRED=$(cat /run/secrets/Haostest)
#export CRED=$(cat /Users/Hao.xu/Desktop/secret)
echo $CRED
curl -v --user $CRED --upload-file $1 $2;