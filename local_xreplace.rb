#!/usr/bin/ruby
cur_dir = Dir.pwd
value = File.read("/home/jenkins/.curr_tail")
filename = "#{cur_dir}/osxcreate-luh.xml"
target = "NCT-Z-10CS-S02B"
goal = "NCT-Z-10CS-#{value}".strip

file_names = ["#{filename}"]
#check to make sure the user input is actually within the file, then proceed with the replacing process.
	if File.readlines("#{filename}").grep(/#{target}/).size > 0
		file_names.each do |file_name|
  			text = File.read(file_name)
  			new_contents = text.gsub(/#{target}/,"#{goal}")

  	# show the file with changes
  		puts new_contents

  	# write changes to the file
  		File.open(file_name, "w") {|file| file.puts new_contents }
  	end
    # User input not found, stop process, inform user.
	elsif File.readlines("#{filename}").grep(/#{target}/).size == 0
  puts ""
  puts ""
	puts "Can't find required content in the file, please double check. :("
  puts ""
  puts ""
end
