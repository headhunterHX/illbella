#!/usr/bin/ruby
require 'find'

cur_dir = Dir.pwd
output = `sha1sum #{cur_dir}/NCT-Z-08CA-*/nfs/NCT-Z-08CA-*/70-dna-layer.cpio.gz | cut -d ' ' -f1`
filename = "#{cur_dir}/NCT-Z-08CA-*/nfs/NCT-Z-08CA-*/sha1sums"
goal = output.gsub("\n",'')
file_paths = Dir.glob "**/*/*/*/sha1sums"
dabest = file_paths[0]
lines = File.readlines(dabest)
lines[7] = goal + '  70-dna-layer.cpio.gz' << $/
File.open(dabest, 'w') { |f| f.write(lines.join)}
p "Sha swap complete!"
