# create_site.rb => thor generator
require 'thor'

module Shpg
  class CreateSiteGenerator < Thor::Group
    include Thor::Actions 
    
    desc("Creates Site")
    
    argument :site_name 
    
    
    def create_site_dir()
    end
    
    def create_config_rb()
    end
    
    def create_pages_rb()
    end
    
    def create_pages_dir()
    end
    
    def create_layouts_dir()
    end
    
    def create_assets_dir()
    end
end
