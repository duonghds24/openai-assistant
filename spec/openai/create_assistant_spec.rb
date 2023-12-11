# frozen_string_literal: true

RSpec.describe OpenaiAssistant::Assistant::Create do
  let(:model) { "gpt-3.5-turbo" }
  let(:instructions) { "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question." }
  let(:create_assistant) { described_class.new }

  describe "#create_assistant" do
    context "with valid parameters" do
      it "returns a new response object of assistant" do
        url = URI.parse(create_assistant.instance_variable_get(:@openai_url))
        req_body = {
          "instructions": instructions,
          "name": "assistant",
          "tools": [{ "type": "code_interpreter" }],
          "model": model
        }.to_json
        response_body = OpenaiAssistant::Mapper::Assistant.new.to_json
        expect(create_assistant.instance_variable_get(:@http_client)).to receive(:call_post).with(url, req_body,
                                                                                                  create_assistant.send(:default_headers)).and_return(double(code: "200", body: response_body))

        result = create_assistant.create_assistant(model, instructions)

        expect(result).to be_an_instance_of(OpenaiAssistant::Mapper::Assistant)
      end
    end

    context "with invalid parameters" do
      it "returns an error response object" do
        url = URI.parse(create_assistant.instance_variable_get(:@openai_url))
        req_body = {
          "instructions": instructions,
          "name": "assistant",
          "tools": [{ "type": "code_interpreter" }],
          "model": model
        }.to_json
        response_body = {
          "error": {
            "message": "The requested model 'gpt-3.5-turb' does not exist.",
            "type": "invalid_request_error",
            "param": "model",
            "code": "model_not_found"
          }
        }.to_json
        expect(create_assistant.instance_variable_get(:@http_client)).to receive(:call_post).with(url, req_body,
                                                                                                  create_assistant.send(:default_headers)).and_return(double(code: "400", body: response_body))

        result = create_assistant.create_assistant(model, instructions)

        expect(result).to be_an_instance_of(OpenaiAssistant::ErrorResponse)
      end
    end
  end
end
