# asset/pbuniq_file_namer.rb
   
module Shpg
  module Asset
    class PastableArray < Array
      def paste(glue)
	temp = []
	index = 0
	while index+1 < size do 
	  temp << self[index]
	  temp << glue
	  index += 1
	end
	temp << self[size-1]
      end
    end

    class PBUniqFileNamer
      NUM_TRY_LIMIT = 1000
      
      def initialize(dir_path, file_path)
	@dir_path = dir_path
	@file_path = file_path
	@file_name = File.basename(file_path)
      end
      
      def getUniqFilename()
	return self.class.get_safe_uniq_filename(Dir.entries(@dir_path), @file_path)
      end
      
      def self.get_trimmed_path_sequence(file_dir_path, relative_base_path)
	sequence = file_dir_path.split(relative_base_path)
	if sequence.size > 1  then
	  sequence.shift # remove the first part
	  sequence = PastableArray(sequence).paste(relative_base_path)
	end
	sequence = File.join(sequence).split(File::Separator)
	return sequence
      end
      
      def self.get_uniq_filename_by_path(dir_entries, file_name, path_sequence)
	index = 0
	
	while index < path_sequence.size do 
	  file_name = path_sequence[index]+"_"+file_name
	  return file_name if not dir_entries.include?(file_name)
	  index += 1
	end
	
	return nil
      end
    
      def self.get_uniq_filename_by_num(dir_entries, file_name, path_sequence, try_limit=NUM_TRY_LIMIT)
	file_name = [path_sequence.join("_"), file_name].join("_")
	try_limit.times do |i|
	  tempfn = ""
	  if File.extname(file_name).length>0 then
	    tempfn = (file_name.split(File.extname(file_name))[0])+(i+1).to_s+File.extname(file_name)
	  else
	    tempfn = file_name+(i+1).to_s
	  end
	  return tempfn if not dir_entries.include?(tempfn)
	end
	return nil
      end
      
      def self.get_uniq_filename(dir_entries, file_path, relative_base_path=nil)
	
	path_sequence = File.split(File.absolute_path(file_path))
	file_name = path_sequence[1]
	path_sequence = path_sequence[0]
	path_sequence = get_trimmed_path_sequence(path_sequence, File.absolute_path(relative_base_path))
	
	result = get_uniq_filename_by_path(dir_entries, file_name, path_sequence)
	if(result==nil) then
	  result = get_uniq_filename_by_num(dir_entries, file_name, path_sequence)
	end
	return result
      end
      
      def self.get_safe_uniq_filename(dir_entries, file_name, try_limit = NUM_TRY_LIMIT)
	
	try_limit.times do |i|
	  tempfn = ""
	  if File.extname(file_name).length>0 then
	    tempfn = (file_name.split(File.extname(file_name))[0])+(i+1).to_s+File.extname(file_name)
	  else
	    tempfn = file_name+(i+1).to_s
	  end
	  return tempfn if not dir_entries.include?(tempfn)
	end
	return nil
      end
	
    end
  end
end

if $0 == __FILE__ then
  dir_entries = ['a', 'b', 'c', 'a.txt', '.', '..']
  file_paths = ['a', 'a/a/a', 'b', 'b/c', 'a.txt', 'e/a.txt', 'e', 'd.txt']
  file_paths.each do |file_path|
    print("For file_path: #{file_path} --> ")
    u = Shpg::AssetManager::PBUniqFileNamer.get_safe_uniq_filename(dir_entries, file_path)
    if(u!=nil) then
      dir_entries << u
      puts(u)
    end
  end
end
