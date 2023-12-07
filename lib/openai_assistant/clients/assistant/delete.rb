# frozen_string_literal: true

module OpenaiAsissistant
  module Assistant
    # An openai assistant
    class Delete < Base
      # @param assistant_id [String] The id of assistant after create
      # @return [String] Message delete the assistant ok or not
      def delete_assistant(assistant_id)
        url = "#{@openai_url}/#{assistant_id}"
        uri = URI(url)
        response = @http_client.call_delete(uri, default_headers)
        return OpenaiAsissistant::ErrorResponse.from_json(response.body) unless response.code == "200"

        true
      end
    end
  end
end
