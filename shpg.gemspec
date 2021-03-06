# frozen_string_literal: true

require_relative "lib/shpg/version"

Gem::Specification.new do |spec|
  spec.name          = "shpg"
  spec.version       = Shpg::VERSION
  spec.authors       = ["mash-97"]
  spec.email         = ["mahimnhd97@gmail.com"]

  spec.summary       = "Static HTML Page Generator"
  spec.description   = "Ruby + ERB based Static HTML Page Generator."
  spec.homepage      = "https://github.com/mash-97/shpg"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://github.com/mash-97/shpg.git"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mash-97/shpg"
  spec.metadata["changelog_uri"] = "https://github.com/mash-97/shpg/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["shpg"] # spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "tempfile", "~> 0.1.1"
  spec.add_dependency "thor", "~> 1.1.0"
  spec.add_dependency "colored", "~> 1.2"
  spec.add_dependency "adsf", "~> 1.4.5"
  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
