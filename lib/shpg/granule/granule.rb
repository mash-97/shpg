# granule/granule.rb

require_relative("../ETOH_molder/ETOH_molder")


module Shpg
    class Granule < Shpg::ETOHMolder
    
        def initialize(*args, **kwargs)
            super(*args, **kwargs)
            @passed_data = {}
        end
        
        def passData(**kwargs)
            @passed_data = kwargs
        end
        
        
        module Includer
            
            def include_granule(granule_erb_file_path, **kwargs)
                granule_abs_path = __rap__ ? File.join(__rap__, granule_erb_file_path) :
                    File.absolute_path(granule_erb_file_path)
                
                granule = Granule.new(granule_abs_path)
                granule.passData(**kwargs)
                granule.set_placer(@placer)
                granule.set_rap(__rap__)
                return granule.get_result()
            end
        end
    
    end
end

