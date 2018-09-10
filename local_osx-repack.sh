#!/bin/bash

cur_dir=$(pwd)
cd ${cur_dir} && wget --no-check-certificate https://nexus3.base2d.com/repository/projects-public/dna/10.0.0.rl3-SNAPSHOT-20180726-0852_NCT-Z-10CS-S02B.zip
zip=(${cur_dir}/*.zip)
value=$(<~/.curr_tail)
zipvalue=(NCT-Z-10CS-${value})
last_dir="${PWD%/[^/]*}"

unzip $zip && rm $zip

cd ${cur_dir}/NCT-Z-10CS-*/ && cp ${cur_dir}/dna-layer.cpio.gz . # && mv dna-layer.cpio.gz 70-dna-layer.cpio.gz

cd ${cur_dir}
#change xml content
chmod +x ${cur_dir}/local_xreplace.rb
ruby ${cur_dir}/local_xreplace.rb

#cd ${cur_dir} && mv ${cur_dir}/scripts/osxcreate-luh.xml .
#cd ${cur_dir} && mv ${cur_dir}/scripts/lspb.jar .
cd ${cur_dir} &&  mkdir tempfolder && cd tempfolder && cp -rf ${cur_dir}/NCT-Z-10CS-*/. .
cd ${cur_dir} && rm -r NCT* && mkdir ${zipvalue} && cd ${zipvalue} && cp -rf ${cur_dir}/tempfolder/. .
cd ${cur_dir}/${zipvalue} && rm *.LUH
cd ${cur_dir} && java -jar lspb.jar -c . osxcreate-luh.xml NCT-Z-10CS-${value}.LUH
cd ${cur_dir} && rm -rf ${cur_dir}/tempfolder

cd ${cur_dir}/${zipvalue} && sed -i '/dna/d' ./sha1sums && sed -i '/NCT-Z-10CS/d' ./sha1sums
#swap sha of 70-dna-layer.cpio.gz for sha1sums
cd ${cur_dir} && chmod +x ${cur_dir}/xshaswap.rb
ruby ${cur_dir}/local_xshaswap.rb
cd ${cur_dir}/${zipvalue} && mv ${cur_dir}/NCT-Z-10CS-${value}.LUH .


cd ${cur_dir} && zip -r ${zipvalue}.zip ${zipvalue}
