# frozen_string_literal: true

RSpec.describe OpenaiAssistant::Assistant::Delete do
  let(:assistant_id) { "assistant_id" }
  let(:delete_assistant) { described_class.new }

  describe "#delete_assistant" do
    context "with valid assistant ID" do
      it "returns a success response object" do
        url = URI.parse("#{delete_assistant.instance_variable_get(:@openai_url)}/#{assistant_id}")
        response_body = {
          "message": "Assistant deleted successfully"
        }.to_json
        expect(delete_assistant.instance_variable_get(:@http_client)).to receive(:call_delete).with(url,
                                                                                                    delete_assistant.send(:default_headers)).and_return(double(code: "200", body: response_body))

        result = delete_assistant.delete_assistant(assistant_id)
        puts result
        expect(result).to be true
      end
    end

    context "with invalid assistant ID" do
      it "returns an error response object" do
        url = URI.parse("#{delete_assistant.instance_variable_get(:@openai_url)}/#{assistant_id}")
        response_body = {
          "error": {
            "message": "The requested assistant 'assistant_id' does not exist.",
            "type": "invalid_request_error",
            "param": "assistant_id",
            "code": "assistant_not_found"
          }
        }.to_json
        expect(delete_assistant.instance_variable_get(:@http_client)).to receive(:call_delete).with(url,
                                                                                                    delete_assistant.send(:default_headers)).and_return(double(code: "400", body: response_body))

        result = delete_assistant.delete_assistant(assistant_id)

        expect(result).to be_an_instance_of(OpenaiAssistant::ErrorResponse)
      end
    end
  end
end
