# page/page.rb

require_relative("../ETOH_molder/ETOH_molder")
require_relative("../granule/granule")
require_relative("../layout/layout")

module Shpg
  class Page < ETOHMolder
    include Shpg::Granule::Includer
    include Shpg::Layout::Setter

    def initialize(*args, **kwargs)
      super(*args, **kwargs)
      @layout = kwargs[:layout]
    end

    def get_result(*args, **kwargs)
      @content = super(*args, **kwargs)
      result = @content

      if @layout
        @layout.setPageContent(@content)
        result = @layout.get_result()
      end
      return result
    end
  end
end
