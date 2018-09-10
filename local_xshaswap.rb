#!/usr/bin/ruby
require 'find'
cur_dir = Dir.pwd
value = File.read("/home/jenkins/.curr_tail").strip

output = `sha1sum #{cur_dir}/NCT-Z-10CS-*/dna-layer.cpio.gz | cut -d ' ' -f1`
output2 = `sha1sum #{cur_dir}/NCT-Z-10CS-*.LUH | cut -d ' ' -f1`
filename = "#{cur_dir}/NCT-Z-10CS-*/sha1sums"
goal = output.gsub("\n",'')
goal2 = output2.gsub("\n",'')
file_paths = Dir.glob "**/*/sha1sums"
dabest = file_paths[0]
lines = File.readlines(dabest)
lines[5] = goal2 + "  NCT-Z-10CS-#{value}.LUH" << $/
lines[7] = goal + '  dna-layer.cpio.gz' << $/
File.open(dabest, 'w') { |f| f.write(lines.join)}
p "Sha swap complete!"
