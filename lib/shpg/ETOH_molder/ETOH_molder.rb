# ETOHMolder
require_relative("base_em")
require_relative("../asset/asset")

module Shpg
	class ETOHMolder < BaseEM
		include Shpg::Asset::Includer
		
		def initialize(*args, **kwargs)
			super(*args, **kwargs)
			self.setup()
		end
		 
		def setup()
		end
    
	end
end


