# asset/asset.rb

module Shpg 
  module Asset
    module Includer
      def set_placer(placer_obj)
        @placer = placer_obj
      end
      
      def include_asset(asset_source_path)
        return @placer.includeAsset(asset_source_path)
      end
    end
  end
end

