# frozen_string_literal: true

require "openai_assistant"
require "vcr"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# VCR.configure do |config|
#   config.cassette_library_dir = "spec/vcr_cassettes"
#   config.hook_into :webmock # or :faraday, :typhoeus, etc.

#   config.define_cassette_placeholder("<KP_TOKEN>") { "xyz" }
# end
