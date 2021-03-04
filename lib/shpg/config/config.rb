# config/config.rb

module Shpg
  class Config 
    SITE_NAME = ""
    LAYOUTS_DIRS = []
    ASSETS_DIRS = []
    OUTPUT_DIR = ""
    PAGES_INFS_FILE_PATH = "pages.rb"
    
    def initialize()
      @site_name = self.class::SITE_NAME
      @layouts_dirs = self.class::LAYOUTS_DIRS
      @assets_dirs = self.class::ASSETS_DIRS 
      @output_dir = self.class::OUTPUT_DIR 
      @pages_infs_file_path = self.class::PAGES_INFS_FILE_PATH
    end

  end

end

