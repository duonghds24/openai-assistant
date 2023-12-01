# frozen_string_literal: true

require_relative "../http/http"

module Openai
  # Base class of openai
  class Base
    def initialize(api_key = "")
      @openai_api_key = api_key
      # hard the host because if the official docs change the host, maybe it will change another
      # we need to update this gem for any change
      @openai_url = "https://api.openai.com/v1/assistants"
      @http_client = Http::Client.new
    end
  end
end
