# Base ETOH Molder
# frozen_string_literal: true

require 'erb'

module Shpg
	class  BaseEM
		ERB_TEMPLATE_FILE_PATH = ""

		def initialize(erb_file_path, *args, **kwargs)
			@erb_file_path = erb_file_path || self.class::ERB_TEMPLATE_FILE_PATH
		end
		def get_result()
			return ERB.new(File.read(@erb_file_path)).result(binding)
		end
	end
end
