require_relative("test_helper")

class PageTest < Minitest::Test 
  
  def test_page()
    page_r = Page.new(TH::PTF.path).get_result()
    assert_equal( eval(page_r), TH::HASH )
  end
end

