# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "shpg"
require "minitest/autorun"
require "tempfile"
require "colored"
require "find"

require 'mashz'
require 'file_disperser'

include Shpg

class TestHelper < Minitest::Test

  def setup()
  end


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

  def self.generateTestAssets(dir_path, **filenames_with_size)
    # puts("passed filenames_with_size: #{filenames_with_size}".yellow_on_white)
    # 
    files = []
    filenames_with_size.each do |filename, size|
      fp = File.join(dir_path, filename)
      f = File.open(fp, "wb")
      chars = ('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a+%w[\\ / -]
      string = size.times.collect do
	r = rand(0..4)
	r==0 ? "\n" :  chars[rand(0...chars.size)]
      end
      f.puts(string)
      f.close()
      files << fp
    end
    return files
  end

  def self.fillWithTestAssets(dir_path, test_assets)
    # create folder tree inside the dir_path
    rfg = FileDisperser::FolderGenerator.new(dir_path)
    rfg.name_table = ["page", "layout", "about", "index", "home"]
    rfg.limits = {:dispersion_range => (2..5), :depth_limit => 4}
    rfg.gen_folders()

    fd = FileDisperser::FileDisperser.new(test_assets, dir_path)
    fd.run(2)

    return Dir[File.join(dir_path, "**/**")].select{|path| File.file?(path)}
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
  GTF = getTT(["granule", ".erb"], GT)


  # =========== LAYOUT ===============
  LT = <<LAYOUT
      <%= include_granule('#{GTF.path}', #{to_kwargss(HASH)}) %>
LAYOUT
  LTF = getTT(["layout", ".erb"], LT)


  # =========== PAGE ===============
  PT = <<PAGE
      <% set_layout('#{LTF.path}') %>
PAGE
  PTF = getTT(["page", ".erb"], PT)



end

TH = TestHelper
