require_relative("test_helper")

class LayoutTest < Minitest::Test
  def test_layout()
    puts("YO! this is layout test")
    assert_equal(eval(Layout.new(TH::LTF.path).get_result()), TH::HASH)
  end
end
