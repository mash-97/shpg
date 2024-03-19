require "test_helper"

class GranuleTest < Minitest::Test
  include Granule::Includer

  def test_granule()
    puts("This is test_granule.")
    granule = Granule.new(TH::GTF.path)
    granule.passData(**TH::HASH)
    assert_equal(eval(granule.get_result()), TH::HASH)
  end

  def test_granule_includer()
    puts("This is test_granule_includer")
    assert_equal(eval(include_granule(TH::GTF.path, **TH::HASH)), TH::HASH)
  end

  def __rap__()
    nil
  end
end
