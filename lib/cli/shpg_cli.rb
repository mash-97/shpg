# frozen_string_literal: true

require "thor"
require "adsf"

require_relative("cli_helper")
require_relative("create_page")
require_relative("create_site")
require_relative("site_generator")

module Shpg
  class ShpgCli < Thor
    include Shpg::CliHelper

    desc "create_site NAME", "create site NAME at the current directory"

    def create_site(site_name)
      print_name(site_name)
      csg = Shpg::CreateSiteGenerator.new([site_name.to_s])
      csg.destination_root = Dir.pwd()
      csg.invoke_all()
      say("\nExceptions not handled!\n".bold.yellow)
    end

    desc "create_page NAME", "create page NAME at the current directory"

    def create_page(page_name)
      print_name(page_name)
      cpg = Shpg::CreatePageGenerator.new([page_name, get_pages_path()])
      cpg.destination_root = Dir.pwd()
      cpg.invoke_all()
      say("\nExceptions not handled!\n".bold.yellow)
    end

    desc "generate", "generates the current site"

    def generate()
      sg = Shpg::SiteGenerator.new([get_config_path()])
      sg.destination_root = Dir.pwd()
      sg.invoke_all()
      say("\nExceptions not handled!\n".bold.yellow)
    end

    desc "server ARGS", "start a server for the generated site"
    option :host, type: :string, default: "127.0.0.1"
    option :port, type: :numeric, default: 3000
    option :zero_host, type: :boolean, default: false

    def server()
      host = options[:host]
      port = options[:port]

      if (options[:zero_host])
        host = "0.0.0.0"
        port = 8080
      end

      interactive_load(get_config_path())
      say("The root page is considered to be 'index.html'".yellow)
      say("Stop the server by Ctrl+C".yellow)
      config = $SITE_CONFIG_CLASS.new()
      server = Adsf::Server.new(root: File.join(Dir.pwd(), config.output_dirname),
                                host: host,
                                port: port)

      %w[INT TERM].each do |signal| Signal.trap(signal) { server.stop() } end

      server.run()
    end
  end
end
