# Base ETOH Molder
require 'erb'

module Shpg
	class  BaseEM	
		def initialize(erb_file_path)
			@erb_file_path = erb_file_path
		end
		def get_result()
			return ERB.new(File.read(@erb_file_path)).result(binding)
		end
	end
end

