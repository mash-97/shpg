# asset/asset.rb
require_relative("../rap/rap")

module Shpg 
  module Asset
    module Includer
      include Shpg::Rap
      
      def set_placer(placer_obj)
        @placer = placer_obj
      end
      
      def include_asset(asset_source_path)
        asset_abs_path = __rap__ ? File.join(__rap__, asset_source_path) :
          File.absolute_path(asset_source_path)
        
        placed_asset_path = @placer.includeAsset(asset_abs_path)
        return placed_asset_path.split(File.dirname(@placer.dest_dir))[1]
      end
    end
  end
end

