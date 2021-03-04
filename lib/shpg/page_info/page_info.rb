# page_info/page_info.rb

module Shpg 
  class PageInfo
    attr_accessor :rb_file_path
    attr_accessor :klass_name
    attr_accessor :klass
    
    def initialize(rb_file_path, klass_name)
      @rb_file_path = rb_file_path
      @klass_name = klass_name
    end
    
    def initializeClass()
      require(File.absolute_path(@rb_file_path)
      @klass = eval(@klass_name)
    end
  end
end

