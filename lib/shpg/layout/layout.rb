# layout/layout.rb

require_relative("../ETOH_molder/ETOH_molder")
require_relative("../granule/granule")
require_relative("../asset/asset")

module Shpg
  class Layout < ETOHMolder
    include Shpg::Granule::Includer
    
    def initialize(*args, **kwargs)
      super(*args, **kwargs)
      @page_content = kwargs[:page_content] 
    end
    
    def setPageContent(page_content)
      @page_content = page_content
    end
    
    def setPageData(**kwargs)
      @page_data = kwargs
    end
    
    module Setter
      def set_layout(layout_erb_file_path, **kwargs)
	@layout = Layout.new(layout_erb_file_path, **kwargs)
	@layout.setPageData(**kwargs)
      end
    end
  end
end

