Gem::Specification.new do |spec|
  spec.name = "jumbo-client"
  spec.version = "0.3.1"
  spec.authors = ["Alessandro Rodi"]
  spec.email = ["alessandro.rodi@renuo.ch"]

  spec.summary = "Invoke Jumbo LMS API easily with ruby"
  spec.description = "This gems allows you to connect to Jumbo LMS API and use the services provided"
  spec.homepage = "https://github.com/renuo/jumbo-client"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/renuo/jumbo-client"
  spec.metadata["changelog_uri"] = "https://github.com/renuo/jumbo-client/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 5.0.0"
  spec.add_dependency "zeitwerk", ">= 2.0.0"
end
