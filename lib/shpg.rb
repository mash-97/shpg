# frozen_string_literal: true

# require each ruby files inside shpg dir
rb_files = Dir.glob(File.join(__dir__,"shpg/**/**/*.rb"))
rb_files.each do |ruby_file|
	require_relative(ruby_file)
end

module Shpg
  class Error < StandardError; end
  # Your code goes here...
end

