# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "shpg"

require "minitest/autorun"

include Shpg

class TestHelper
  def self.to_kwargss(hash)
    kv_strings = hash.collect{|key,value| "'#{key}' => #{value}"}
    return kv_strings.join(",")
  end
  
  def self.getTT(file_name, template)
    tmpf = Tempfile.new(file_name)
    tmpf.puts(template)
    tmpf.close()
    return tmpf
  end
  
  HASH = ('a'..'z').collect{|x| [x, rand(0..3433)]}.to_h
  
  # =========== GRANULE ===============
  GT = <<GRANULE
    {
	<% @passed_data.each do |key, value| %>
	  "<%= key %>" => <%= value %>,
	<% end %>
      }
GRANULE
  GTF = getTT("granule.erb", GT)


  # =========== LAYOUT ===============
  LT = <<LAYOUT 	
      <%= include_granule('#{GTF.path}', #{to_kwargss(HASH)}) %>
LAYOUT
  LTF = getTT("layout.erb", LT)


  # =========== PAGE ===============
  PT = <<PAGE
      <% set_layout('#{LTF.path}') %>
PAGE
  PTF = getTT("page.erb", PT)

end

TH = TestHelper
    
