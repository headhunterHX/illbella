#!/bin/bash


## Unzip known-good OS part
# Replace dna layer
# Create version of attached XML with updated OS part number
# Rebuild LUH using below. Please note this is a Boeing Proprietary .jar file.
# Rezip part

#### java -jar "${lspb_jar}" -c "${work_dir}" "$(basename ${lspb_xml})" "$(basename ${luh_file})"

#os-part="${8.0.0.er1-SNAPSHOT-20180518-0629_NCT-Z-08CA-803B.zip}"
cur_dir=$(pwd)
zip=(${cur_dir}/*.zip) 
value=$(<~/.curr_tail)
zipvalue=(NCT-Z-08CA-${value})
last_dir="${PWD%/[^/]*}"

# pull os part from nexus
unzip $zip && #rm $zip
cd ${cur_dir}/NCT-Z-08CA-*
#unzip LUP file
tar -xvf *.LUP

# pull cpio from jenkins and rename it
# ops-os is lived jenkins'.  base2 solution>>>ons-dna>>>develop
# download ops-os.cpio.gz from jenkins
cd ${last_dir} && cp dna-layer.cpio.gz ${cur_dir}
cd ${cur_dir}/NCT-Z-08CA-*/nfs/NCT-Z-08CA-*/ && cp ${cur_dir}/dna-layer.cpio.gz . && mv dna-layer.cpio.gz 70-dna-layer.cpio.gz


cd ${cur_dir}
#change xml content
chmod +x ${cur_dir}/replace.rb
ruby ${cur_dir}/replace.rb
#swap sha of 70-dna-layer.cpio.gz for sha1sums
chmod +x ${cur_dir}/shaswap.rb
ruby ${cur_dir}/shaswap.rb



lspb_jar=(${cur_dir}/lspb.jar)

# lspb_xml=(${cur_dir}/create-luh.xml)
 luh_path="${cur_dir}/NCT-Z-08CA-*/*.LUH" 
 lup_path="${cur_dir}/NCT-Z-08CA-*/*.LUP" 
 #lup_file=$(basename $lup_path)
 #luh_file=$(basename $luh_path)
# echo $luh_file
# echo $lup_file

### xml should only include LUP, java-jar needs to be run everytime LUP got repackaged, LUH name needs to be fixed as well ******
# ###  LUP creation
  cd ${cur_dir}/NCT-Z-08CA-* && rm *.LUP && rm *.LUH && tar -cvf NCTZ08CA${value}000.LUP nfs && mv *.LUP ${cur_dir}
# # # ### LUH creation
  cd ${cur_dir} && java -jar ${lspb_jar} -c . create-luh.xml NCT-Z-08CA-${value}.LUH
  # cd ${cur_dir} && rm -rf NCT-Z-* && mkdir ${zipvalue}
  mkdir ${zipvalue} && cd ${zipvalue} && mv ${cur_dir}/*.LUH . && mv ${cur_dir}/*.LUP .
  cd ${cur_dir} && zip -r ${zipvalue}.zip ${zipvalue}



