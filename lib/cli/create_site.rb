# create_site.rb
# frozen_string_literal: true

module Shpg
  class CreateSiteGenerator < Thor::Group
    include Thor::Actions

    desc("Creates Site")

    argument :site_name

    def self.source_root()
      return File.expand_path("../../data", __dir__)
    end

    def __site_name__()
      site_name.snakify
    end

    def create_config_rb()
      template("templates/config.erb", File.join(__site_name__, "config.rb"))
    end

    def create_pages_rb()
      template("templates/pages.erb", File.join(__site_name__, "pages.rb"))
    end

    def initialize_granules_dir()
      copy_file("html_head.erb", File.join(__site_name__, "granules", "html_head.erb"))
    end

    def initialize_layouts_dir()
      copy_file("default_layout.erb", File.join(__site_name__, "layouts", "default_layout.erb"))
    end

    def initialize_assets_dir()
      copy_file("style.css", File.join(__site_name__, "assets", "style.css"))
    end

    def create_index_page()
      pg = Shpg::CreatePageGenerator.new(["index", File.join(__site_name__, "pages.rb")])
      pg.destination_root = File.join(destination_root, __site_name__)
      pg.invoke_all()
    end
  end
end

if $0 == __FILE__
  csg = Shpg::CreateSiteGenerator.new(["mango"])
  csg.destination_root = __dir__
  csg.invoke_all()
end
