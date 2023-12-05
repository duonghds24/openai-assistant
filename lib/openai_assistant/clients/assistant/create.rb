# frozen_string_literal: true

module Openai
  module Assistant
    # An openai assistant
    class Create < Base
      # @param model [String] Select model of the assistant. refer on: https://platform.openai.com/docs/api-reference/models/list.
      # @param instructions [String] The system instructions that the assistant uses.
      # @return [Openai::AssistantObj] A new response object of assistant.
      def create_assistant(model, instructions)
        url = URI.parse(@openai_url)
        req_body = {
          "instructions": instructions,
          "name": "assistant",
          "tools": [{ "type": "code_interpreter" }],
          "model": model
        }.to_json
        response = @http_client.call_post(url, req_body, default_headers)
        return Openai::ErrorResponse.from_json(response.body) unless response.code == "200"

        Openai::Mapper::Assistant.from_json(JSON.parse(response.body))
      end
    end
  end
end
