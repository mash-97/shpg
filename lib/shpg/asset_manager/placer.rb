require 'yaml'
require 'tempfile'
require_relative("file_checksum")

module Shpg 
  module AssetManager
    class Placer
      def initialize(dest_dir)
	@dest_dir = dest_dir
	@container = []
	@yaml_file = Tempfile.new(["asset_placer", ".yaml"])
	@yaml_file.close()
      end
      
      
      
    end
  end
end

