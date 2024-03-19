# config/config.rb

module Shpg
  class Config
    SITE_NAME = ""
    OUTPUT_DIRNAME = "output"
    PAGES_PATH = "pages.rb"

    attr_accessor :site_name
    attr_accessor :output_dirname
    attr_accessor :pages_path

    def initialize()
      @site_name = self.class::SITE_NAME
      @output_dirname = self.class::OUTPUT_DIRNAME
      @pages_path = self.class::PAGES_PATH
    end
  end
end
