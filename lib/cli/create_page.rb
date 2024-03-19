# cli/create_page.rb
# frozen_string_literal: true

module Shpg
  class CreatePageGenerator < Thor::Group
    include Thor::Actions

    desc("Creates Page")

    argument :page_name
    argument :pages_file_path

    def self.source_root()
      return File.expand_path("../../data", __dir__)
    end

    def initializePaths()
      @erb_file_path = File.join(page_name.snakify, page_name.snakify + ".erb")
      @class_file_path = File.join(page_name.snakify, page_name.snakify + ".rb")
    end

    def create_page_template_erb_file()
      create_file(@erb_file_path) do
        %[<% set_layout("layouts/default_layout.erb", title: "#{page_name.snakify}") %>]
      end
    end

    def create_page_class_rb_file()
      template("templates/page_class.erb", @class_file_path)
    end

    def register_with_page_info()
      pages_file = File.open(pages_file_path, "a")
      temp = %[$PAGES << Shpg::PageInfo.new("#{page_name.snakify}", "#{@class_file_path}", "#{page_name.camelize}");]
      pages_file.puts(temp)
    end
  end
end

if $0 == __FILE__
  cpg = Shpg::CreatePageGenerator.new(["nash", "./pages.rb"])
  cpg.destination_root = "pages"
  cpg.invoke_all()
end
