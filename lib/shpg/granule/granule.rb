# granule/granule.rb

require_relative("../ETOH_molder/ETOH_molder")
require_relative("../asset/asset")

module Shpg
  class Granule < Shpg::ETOHMolder
    
    def passData(**kwargs)
      @passed_data = kwargs
    end
    
    
    module Includer
      def include_granule(granule_erb_file_path, **kwargs)
        granule = Granule.new(granule_erb_file_path)
        granule.passData(**kwargs)
        return granule.get_result()
      end
    end
    
  end
end

