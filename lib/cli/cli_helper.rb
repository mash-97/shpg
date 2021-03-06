module Shpg
  module CliHelper
    private 
      def interactive_load(abs_file_path, tabs="")
	load_result = load(abs_file_path)
	load_result = load_result == true ? load_result.to_s.bold.green : load_result.to_s.bold.red
	say(tabs+"load ".bold.magenta+abs_file_path.to_s.bold.cyan+" -> ".bold.magenta+load_result)
      end
      
      def get_config_path()
	config_file_path = Dir.entries(Dir.pwd()).select{|x| x=~/^config.rb$/}[0]
	config_file_path = File.join(Dir.pwd(), config_file_path)
	return config_file_path
      end
      
      def get_pages_path()
	interactive_load(get_config_path())
	config = $SITE_CONFIG_CLASS.new()
	return config.pages_path
      end
      
      def print_name(name, tabs="")
	say("#{name.bold.magenta} -> #{name.snakify.bold.green}")
      end
  end
end
    
