# page_info/page_info.rb

module Shpg
  class PageInfo
    attr_accessor :page_name
    attr_accessor :class_file_path
    attr_accessor :klass_name

    def initialize(page_name, class_file_path, klass_name)
      @page_name = page_name
      @class_file_path = class_file_path
      @klass_name = klass_name
    end
  end
end
