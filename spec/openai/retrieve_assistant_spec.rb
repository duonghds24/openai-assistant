# frozen_string_literal: true

RSpec.describe OpenaiAsissistant::Assistant::Retrieve do
  let(:assistant_id) { "assistant_id" }
  let(:retrieve_assistant) { described_class.new }

  describe "#retrieve_assistant" do
    context "with valid parameters" do
      it "returns a response object of assistant" do
        url = URI.parse("#{retrieve_assistant.instance_variable_get(:@openai_url)}/#{assistant_id}")
        response_body = OpenaiAsissistant::Mapper::Assistant.new.to_json
        expect(retrieve_assistant.instance_variable_get(:@http_client)).to receive(:call_get).with(url,
                                                                                                   retrieve_assistant.send(:default_headers)).and_return(double(
                                                                                                                                                           code: "200", body: response_body
                                                                                                                                                         ))

        result = retrieve_assistant.retrieve_assistant(assistant_id)

        expect(result).to be_an_instance_of(OpenaiAsissistant::Mapper::Assistant)
      end
    end

    context "with invalid parameters" do
      it "returns an error response object" do
        url = URI.parse("#{retrieve_assistant.instance_variable_get(:@openai_url)}/#{assistant_id}")
        response_body = {
          "error": {
            "message": "The requested assistant 'assistant_id' does not exist.",
            "type": "invalid_request_error",
            "param": "assistant_id",
            "code": "assistant_not_found"
          }
        }.to_json
        expect(retrieve_assistant.instance_variable_get(:@http_client)).to receive(:call_get).with(url,
                                                                                                   retrieve_assistant.send(:default_headers)).and_return(double(
                                                                                                                                                           code: "400", body: response_body
                                                                                                                                                         ))

        result = retrieve_assistant.retrieve_assistant(assistant_id)

        expect(result).to be_an_instance_of(OpenaiAsissistant::ErrorResponse)
      end
    end
  end
end
