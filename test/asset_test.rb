require "test_helper"

class AssetTest < Minitest::Test
  def setup()
    @assets_dir = File.expand_path("assets", File.dirname(__FILE__))
    FileUtils.mkdir(@assets_dir) if not Dir.exist?(@assets_dir)

    @assets = TH.generateTestAssets(@assets_dir, "style.css" => 1024, "style.scss" => 2048, "me.jpg" => 1024 ** 2, "m.png" => 2 * 1024 ** 2)
    @dispersed_assets = TH.fillWithTestAssets(@assets_dir, @assets)

    @output_dir = File.expand_path("output", __dir__)
    FileUtils.mkdir(@output_dir) if not Dir.exist?(@output_dir)

    @placer = Shpg::Asset::Placer.new(@output_dir)

    @ptl = ->(path) { return "<%= include_asset('#{path}') %>" }
  end

  def teardown()
    FileUtils.remove_dir(@assets_dir, force: true)
  end

  def test_asset_on_page()
    @dispersed_assets.each do |asset_path|
      puts("For asset: #{asset_path.bold.blue}")
      pt = @ptl.call(asset_path)
      ptf = TH.getTT(["page", ".erb"], pt)
      page = Shpg::Page.new(ptf.path)
      page.set_placer(@placer)
      page_result = page.get_result()

      # @placer's @container's last element should be for the asset
      puts("\tpage_result: #{page_result} and @placer.container[-1]: #{@placer.container[-1]}")
      assert(@placer.container.collect { |x| x[:checksum] } ==
             @placer.container.collect { |x| x[:checksum] }.uniq)
    end
  end
end
