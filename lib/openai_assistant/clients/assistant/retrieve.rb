# frozen_string_literal: true

module Openai
  module Assistant
    # An openai assistant
    class Retrieve < Base
      # @param assistant_id [String] The id of assistant after create
      # @return [Openai::AssistantObj] A new response object of assistant.
      def retrieve_assistant(assistant_id)
        url = "#{@openai_url}/#{assistant_id}"
        uri = URI(url)
        response = @http_client.call_get(uri, default_headers)
        return Openai::ErrorResponse.from_json(response.body) unless response.code == "200"

        Openai::Mapper::Assistant.from_json(JSON.parse(response.body))
      end
    end
  end
end
