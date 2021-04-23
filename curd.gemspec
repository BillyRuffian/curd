require_relative 'lib/curd/version'

Gem::Specification.new do |spec|
  spec.name          = "curd"
  spec.version       = Curd::VERSION
  spec.authors       = ["Nigel Brookes-Thomas"]
  spec.email         = ["nigel@brookes-thomas.co.uk"]

  spec.summary       = 'Cucumber Documenter'
  spec.description   = 'Cucumber documenter'
  spec.homepage      = 'https://www.billy-ruffian.co.uk'
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://www.github.com'
  spec.metadata["changelog_uri"] = 'https://www.github.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", "~> 0.12"

  spec.add_runtime_dependency 'cuke_modeler', '~> 3.8'
  spec.add_runtime_dependency 'haml', '~> 5.2'
  spec.add_runtime_dependency 'tilt', '~> 2.0'
end
