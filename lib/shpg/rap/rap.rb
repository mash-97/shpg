# root abs path
# root absolute path

module Shpg 
  module Rap
    def set_rap(root_abs_path)
      @rap = root_abs_path ? File.absolute_path(root_abs_path) : nil;
    end
    
    def __rap__()
      return @rap
    end
  end
end

