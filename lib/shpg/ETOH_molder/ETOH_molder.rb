# ETOHMolder
# frozen_string_literal: true

require_relative("base_em") 
require_relative("../asset/asset")
require_relative("../rap/rap")

module Shpg
	class ETOHMolder < BaseEM
		include Shpg::Rap
		include Shpg::Asset::Includer

		NAME = ""
		attr_accessor :name

		def initialize(*args, **kwargs)
			super(*args, **kwargs)
			self.setup()
			@name = self.class::NAME
			@placer = kwargs[:placer]
			@rap = kwargs[:rap]

		end

		def setup()
		end

	end
end
