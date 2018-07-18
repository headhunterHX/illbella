#!/bin/bash

cur_dir=$(pwd)
cd ${cur_dir} && wget --no-check-certificate https://nexus3.base2d.com/repository/projects-public/dna/8.0.0.er5-SNAPSHOT-20180611-0152_NCT-Z-08CA-804C.zip
zip=(${cur_dir}/*.zip) 
value=$(<~/.curr_tail)
zipvalue=(NCT-Z-08CA-${value})
last_dir="${PWD%/[^/]*}"

cd ${cur_dir} && unzip $zip && rm $zip
oldname=(${cur_dir}/NCT-Z-08CA-*)
cd ${cur_dir}/NCT-Z-08CA-* && tar -xvf *.LUP


cd ${cur_dir}/NCT-Z-08CA-*/nfs/NCT-Z-08CA-*/ && cp ${cur_dir}/dna-layer.cpio.gz 70-dna-layer.cpio.gz


cd ${cur_dir}
#change xml content
chmod +x ${cur_dir}/scripts/replace.rb
ruby ${cur_dir}/scripts/replace.rb
#swap sha of 70-dna-layer.cpio.gz for sha1sums
chmod +x ${cur_dir}/scripts/shaswap.rb
ruby ${cur_dir}/scripts/shaswap.rb



#lspb_jar=(${cur_dir}/scripts/lspb.jar)
cd ${cur_dir} && mv ${cur_dir}/scripts/create-luh.xml .
cd ${cur_dir} && mv ${cur_dir}/scripts/lspb.jar .


cd ${cur_dir}/NCT-Z-08CA-* && cp -rf nfs ${cur_dir}
cd ${cur_dir} && mkdir tempfolder && cd tempfolder && cp -rf ${cur_dir}/nfs . && cd nfs && mv NCT* ${zipvalue} && cd - && tar -cvf NCTZ08CA${value}000.LUP nfs && mv *.LUP ${cur_dir}
cd ${cur_dir} && mkdir ${zipvalue} && cd ${zipvalue} && cp -rf ${cur_dir}/tempfolder/nfs .
cd ${cur_dir} && java -jar lspb.jar -c . create-luh.xml NCT-Z-08CA-${value}.LUH
cd ${cur_dir} && rm -rf ${zipvalue} && mkdir ${zipvalue} && cd ${zipvalue} && mv ${cur_dir}/*.LUP . && mv ${cur_dir}/*.LUH .
cd ${cur_dir} && zip -r ${zipvalue}.zip ${zipvalue}
#House cleaning
cd ${cur_dir} && rm -r tempfolder && rm -r nfs


