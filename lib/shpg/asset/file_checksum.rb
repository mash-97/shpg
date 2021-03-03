# asset/file_checksum.rb

require 'digest/md5'
require 'colored'

module Shpg 
  module Asset
  # FileChecksum uses MD5
    class FileChecksum
      DEFAULT_BLOCK_SIZE = 1024**2
      SIZE_CHECK_LIMIT = 10*1024**2		# 10 MB
      attr_accessor :checksum
      attr_accessor :file_path
      
      def initialize(file_path)
	@file_path = file_path
      end
      
      def generate_checksum(block_size = self.class::DEFAULT_BLOCK_SIZE)
	@checksum = self.class.get_checksum(@file_path, block_size)
      end
      
      def self.get_checked(file_path)
	puts("Large File Time Consuming: #{file_path.bold.red_on_cyan}".bold.red) if File.size(file_path) > SIZE_CHECK_LIMIT
      end
      
      def self.get_checksum(file_path, block_size = DEFAULT_BLOCK_SIZE, need_check=true)
	self.get_checked(file_path) if need_check
	
	digest = Digest::MD5.new()
	
	file = File.open(file_path, "rb")
	until file.eof? do digest.update(file.read(block_size)) end
	return digest.hexdigest()
      end
      
      def self.compare_File(file1_path, file2_path, block_size = DEFAULT_BLOCK_SIZE, need_check=true)
	self.get_checked(file1_path) if need_check
	self.get_checked(file2_path) if need_check
	file1 = File.open(file1_path, "rb")
	file2 = File.open(file2_path, "rb")
	
	return false if file1.size != file2.size
	
	until file1.eof? do 
	  return false if(file1.read(block_size) != file2.read(block_size))
	end
	return true
      end
    end
  end
end


