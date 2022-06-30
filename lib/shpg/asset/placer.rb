# asset/placer.rb

# ~ require 'yaml'
# ~ require 'tempfile'
require "fileutils"

require_relative("asset")
require_relative("file_checksum")
require_relative("pbuniq_file_namer")

module Shpg
  module Asset
    class Placer
      class UnableToProduceDestFilePath < StandardError
        def initialize(message, dest_dir, file_path)
          @dest_dir = dest_dir
          @file_path = file_path
          super(message)
        end
      end

      attr_accessor :container, :dest_dir, :yaml_file

      def initialize(dest_dir)
        @dest_dir = dest_dir
        # ~ @yaml_file = Tempfile.new(["container", ".yml"])
        @container = []
        # ~ YAML.dump(@container, @yaml_file)
      end

      def includeAsset(asset_path)
        asset_checksum = Shpg::Asset::FileChecksum.get_checksum(asset_path)
        dest_path = getPathFromContainer(asset_checksum)

        if !dest_path
          filename = File.basename(asset_path)
          if File.exist?(File.join(@dest_dir, filename))
            filename = Shpg::Asset::PBUniqFileNamer.get_safe_uniq_filename(Dir.entries(@dest_dir), filename,
                                                                           try_limit = 3000)
          end
          dest_path = File.join(@dest_dir, filename) if filename
        else
          return dest_path
        end

        # I get the feel I need to remove this logic
        # if no dest_path will be unabled to find with the current configs
        unless dest_path
          raise UnableToProduceDestFilePath.new("Unable to find a file path to avoid filename conflict!", @dest_dir,
                                                asset_path)
        end

        # place the asset_path file at the @dest_dir with the new name dest_path name
        FileUtils.copy(asset_path, dest_path)
        dest_checksum = Shpg::Asset::FileChecksum.get_checksum(asset_path)
        return "" if !File.exist?(dest_path) || (dest_checksum != asset_checksum)

        asset_data = { path: dest_path, old_path: asset_path, checksum: asset_checksum }
        @container << asset_data
        # ~ dumpContainerInYaml()

        asset_data[:path]
      end

      private

      # ~ def dumpContainerInYaml()
      # ~ YAML.dump(@container, File.open(@yaml_file_path))
      # ~ end

      def getPathFromContainer(checksum)
        @container.each do |hash|
          return hash[:path] if hash[:checksum] == checksum
        end
        nil
      end
    end
  end
end
