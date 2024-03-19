# layout/layout.rb

require_relative("../ETOH_molder/ETOH_molder")
require_relative("../granule/granule")

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
        layout_abs_path = __rap__ ? File.join(__rap__, layout_erb_file_path) :
          File.absolute_path(layout_erb_file_path)

        @layout = Layout.new(layout_abs_path, **kwargs)
        @layout.setPageData(**kwargs)
        @layout.set_rap(__rap__)
        @layout.set_placer(@placer)
      end
    end
  end
end
