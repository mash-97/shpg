require 'thor'

module Shpg 
  class CreatePageGenerator < Thor::Group
    include Thor::Assets 
    
    desc("Creates Page")
    
    argument :page_name
    
    def create_page_dir()
    end
    
    def create_page_erb()
    end
    
    def create_page_rb()
    end
    
    def register_with_page_info()
    end
  end
end

    
  
