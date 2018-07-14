lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simplatra/version"

Gem::Specification.new do |spec|
  spec.name          = "simplatra"
  spec.version       = Simplatra::VERSION
  spec.authors       = ["Edwin Onuonga"]
  spec.email         = ["edwinonuonga@gmail.com"]

  spec.summary       = %q{Lightweight and ready-to-use web-application templating for Ruby's Sinatra DSL.}
  spec.description   = %q{A simple MVC Sinatra template for creating dynamic web applications. Bundled with asset pipeline/preprocessing, view helpers, easy management of static data and options for blog-aware development.}
  spec.homepage      = "https://simplatra.gitbook.io/simplatra/"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.5"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3"

  spec.add_runtime_dependency "string-builder", "~> 2.3"
  spec.add_runtime_dependency "activesupport", "~> 5.2"
  spec.add_runtime_dependency "front_matter_parser", "0.2.0"
  spec.add_runtime_dependency "thor", "~> 0.20"
end
