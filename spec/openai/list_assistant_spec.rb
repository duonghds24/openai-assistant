# frozen_string_literal: true

RSpec.describe OpenaiAssistant::Assistant::List do
  let(:list_assistant) { described_class.new }

  describe "#list_assistant" do
    it "returns a list of assistants" do
      url = URI.parse(list_assistant.instance_variable_get(:@openai_url))
      response_body = {
        "data": [
          {
            "id": "assistant_id_1",
            "name": "Assistant 1",
            "object": "assistant",
            "created": 1_620_000_000,
            "updated": 1_620_000_000,
            "instructions": "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question.",
            "model": "davinci",
            "organization": "org_id",
            "owner": "user_id",
            "permissions": %w[
              read
              update
              delete
            ],
            "tools": [
              {
                "id": "tool_id_1",
                "name": "Code Interpreter",
                "type": "code_interpreter"
              }
            ]
          },
          {
            "id": "assistant_id_2",
            "name": "Assistant 2",
            "object": "assistant",
            "created": 1_620_000_000,
            "updated": 1_620_000_000,
            "instructions": "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question.",
            "model": "davinci",
            "organization": "org_id",
            "owner": "user_id",
            "permissions": %w[
              read
              update
              delete
            ],
            "tools": [
              {
                "id": "tool_id_1",
                "name": "Code Interpreter",
                "type": "code_interpreter"
              }
            ]
          }
        ]
      }.to_json
      expect(list_assistant.instance_variable_get(:@http_client)).to receive(:call_get).with(url,
                                                                                             list_assistant.send(:default_headers)).and_return(double(
                                                                                                                                                 code: "200", body: response_body
                                                                                                                                               ))

      result = list_assistant.list_assistant
      expect(result).to be_an_instance_of(Array)
      expect(result.length).to eq(2)
      expect(result[0]["id"]).to eq("assistant_id_1")
      expect(result[0]["name"]).to eq("Assistant 1")
      expect(result[1]["id"]).to eq("assistant_id_2")
      expect(result[1]["name"]).to eq("Assistant 2")
    end
  end
end
