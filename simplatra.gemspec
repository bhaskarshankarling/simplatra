lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simplatra/version"

Gem::Specification.new do |spec|
  spec.name          = "simplatra"
  spec.version       = Simplatra::VERSION
  spec.authors       = ["Edwin Onuonga"]
  spec.email         = ["edwinonuonga@gmail.com"]

  spec.summary       = %q{A simple MVC Sinatra template and CLI for creating dynamic web applications.}
  spec.homepage      = "https://simplatra.gitbook.io/simplatra/"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.5"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.7"

  spec.add_runtime_dependency "string-builder", "~> 2.3"
  spec.add_runtime_dependency "activesupport", "~> 5.2"
  spec.add_runtime_dependency "front_matter_parser", "0.2.0"
  spec.add_runtime_dependency "thor", "~> 0.20"

  spec.metadata = {
    "documentation_uri" => "https://simplatra.gitbook.io/simplatra/",
    "source_code_uri"   => "https://github.com/simplatra/simplatra"
  }
end