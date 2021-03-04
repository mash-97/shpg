require "thor"

module Shpg 
  class SiteGenerator < Thor::Group 
    include Thor::Actions 
    
    desc("Generates Site")
    
    argument :config_file_path
    
    def load_config()
      require(config_file_path)
      @config = $SITE_CONFIG_CLASS.new()
    end
    
    def require_pages_info_file_from_config()
      require(@config.pages_info_file_path)
    end
    
    def initialize_all_pages()
      $PAGES.each do |page_info|
	page_info.initializeClass()
      end
    end
    
    def initialize_output_dir()
      
    end
    
    def create_assets_dir()
    end
    
    def initialize_asset_placer()
    end
    
    def go_through_all_pages()
      # get pages from 
    end
    
  end
end

