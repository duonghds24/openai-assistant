# frozen_string_literal: true

module OpenaiAsissistant
  module Assistant
    # An openai assistant
    class List < Base
      # @return [Array<OpenaiAsissistant::Mapper::Assistant>] List all assistant
      def list_assistant
        url = @openai_url
        uri = URI(url)
        response = @http_client.call_get(uri, default_headers)
        return OpenaiAsissistant::ErrorResponse.from_json(response.body) unless response.code == "200"

        parsed = JSON.parse(response.body)
        assistants = []
        parsed["data"].each do |ast|
          assistants << OpenaiAsissistant::Mapper::Assistant.from_json(ast)
        end
      end
    end
  end
end
