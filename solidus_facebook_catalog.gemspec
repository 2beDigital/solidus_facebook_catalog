
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "solidus_facebook_catalog/version"

Gem::Specification.new do |spec|
  spec.name          = "solidus_facebook_catalog"
  spec.version       = SolidusFacebookCatalog::VERSION
  spec.authors       = ["Noel"]
  spec.email         = ["noel@2bedigital.com"]

  spec.summary       = %q{Send products catalog to facebook}
  spec.description   = %q{This gem permit us to send our products catalog to facebook to create Dynamic Ads}
  spec.homepage      = "https://github.com/2bedigital/solidus_facebook_catalog"

 
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'solidus_core', '~> 2.1'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
