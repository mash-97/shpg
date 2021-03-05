require "thor"
require_relative("../shpg")

module Shpg 
  class SiteGenerator < Thor::Group 
    include Thor::Actions 
    
    desc("Generates Site")
    
    argument :config_file_path
    
    def initialize_globals()
      $SITE_CONFIG_CLASS = nil
      $PAGES = []
    end
    
    def load_config()
        # loading file
        interactive_load(config_file_path)
        
        @config = $SITE_CONFIG_CLASS.new()
    end
    
    def initialize_output_dir()
        @output_dir = File.join(destination_root, @config.output_dirname)
        if Dir.exist?(@output_dir) then
            FileUtils.rm_rf(@output_dir)
        end
        empty_directory("output")
        empty_directory("output/assets")
    end
    
    def initialize_asset_placer()
        @placer = Shpg::Asset::Placer.new(File.join(@output_dir, "assets"))
    end
    
    def load_pages()
      pages_path = @config.pages_path
      
      # loading file
      interactive_load(pages_path)
    end
    
    def process_all_pages()
      $PAGES.each do |page|
        abs_class_file_path = File.join(destination_root, page.class_file_path)
        
        # loading file
        interactive_load(abs_class_file_path)
                
        page_obj = eval(page.klass_name).new(nil, placer: @placer)
        page_obj.set_placer(@placer)
        
        page_obj.set_rap(destination_root)
        
        page_name = (page_obj.name || page.page_name)
        
        # file to put result inside after the page generates
        page_output_path = File.join(@config.output_dirname, page_name + ".html")
        
        create_file(page_output_path) do page_obj.get_result() end
      end
      
    end
    
    private 
    def interactive_load(abs_file_path)
        load_result = load(abs_file_path)
        load_result = load_result == true ? load_result.to_s.bold.green : load_result.to_s.bold.red
        say("\tload: ".bold.magenta+abs_file_path.to_s.bold.cyan+" -> ".bold.magenta+load_result)
    end
    
  end
end

if $0 == __FILE__ then
    sg = Shpg::SiteGenerator.new([File.absolute_path("mango/config.rb")])
    sg.destination_root = File.absolute_path("mango")
    sg.invoke_all()
end

