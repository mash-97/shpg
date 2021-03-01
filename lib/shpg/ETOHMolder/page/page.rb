# Page

require_relative("../ETOH_molder")
require_relative("../granule/granule")
require_relative("../layout/layout")


module Shpg
  class Page < ETOHMolder
    include Shpg::Granule::Includer
    include Shpg::Layout::Setter
    
    def initialize(*args, **kwargs)
      super(*args, **kwargs)
      self.setup()
    end
    
    def setup()
    end
    
    def get_result(*args, **kwargs)
      @content = super()
      result = @content
      
      if @layout then
        @layout.setPageContent(@content)
        result = @layout.get_result()
      end
      return result
    end
  end
end


