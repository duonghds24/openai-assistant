# frozen_string_literal: true

require_relative "lib/openai/assistant/version"

Gem::Specification.new do |spec|
  spec.name = "openai-assistant"
  spec.version = Openai::Assistant::VERSION
  spec.authors = ["duonghds"]
  spec.email = ["duong.hoang@employmenthero.com"]

  spec.summary = "demo openai assistant"
  spec.description = "demo openai assistant"
  spec.homepage = "https://rubygems.org/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.8"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/duonghds24/openai-assistant"
  spec.metadata["changelog_uri"] = "https://github.com/duonghds24/openai-assistant/blob/main/CHANGELOG.md"
  spec.metadata = { "documentation" => "http://www.rubydoc.info/gems/api_duonghds" }
  spec.add_development_dependency "rspec", "~> 3.2"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
