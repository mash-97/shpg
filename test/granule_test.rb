require 'test_helper'

include Shpg

class GranuleTest < Minitest::Test
  include Granule::Includer
  
  def setup()
    @erb_template = <<ERB
      {
	<% @passed_data.each do |key, value| %>
	  "<%= key %>" => <%= value %>,
	<% end %>
      }
ERB
  
    @a_hash = ('a'..'z').collect{|x| [x, rand(0..3433)]}.to_h
    
    @tmp_erb_file = Tempfile.new("granule.rb.erb")
    @tmp_erb_file.puts(@erb_template)
    @tmp_erb_file.close()
  end
  
  
  def test_granule()
    granule = Granule.new(@tmp_erb_file.path)
    granule.passData(**@a_hash)
    assert_equal(eval(granule.get_result()), @a_hash)
  end
  

  def test_granule_includer()
    assert_equal(eval(include_granule(@tmp_erb_file.path, **@a_hash)), @a_hash)
  end

end

