# frozen_string_literal: true

module OpenaiAssistant
  # Base class of openai
  class Base
    def initialize(api_key = "")
      @openai_api_key = api_key
      # hard the host because if the official docs change the host, maybe it will change another
      # we need to update this gem for any change
      @openai_url = "https://api.openai.com/v1/assistants"
      @http_client = OpenaiAssistant::HTTPClient.new
    end

    def default_headers
      {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
    end
  end
end
