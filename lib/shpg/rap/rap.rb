# root abs path
# root absolute path

module Shpg 
  module Rap
    def set_rap(root_abs_path)
      @rap = File.absolute_path(root_abs_path)
    end
    
    def __rap__()
      return @rap
    end
  end
end

