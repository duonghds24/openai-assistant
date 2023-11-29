# frozen_string_literal: true

RSpec.describe Openai::Assistant do
  subject { described_class.new("mock_api") }

  describe ".create_assistant" do
    context "with valid parameters" do
      it "creates an assistant" do
        model = "gpt-3.5-turbo"
        instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
        expect(RestClient).to receive(:post).and_return(double(code: 200, body: '{"id": "assistant_id"}'))
        assistant = subject.create_assistant(model, instructions)
        expect(assistant.id).to eq "assistant_id"
      end
    end

    context "with invalid model" do
      it "raises an error" do
        model = "invalid_model"
        instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
        expect(RestClient).to receive(:post).and_return(double(code: 404, body: '{"error": {"code": "model_not_found"}}'))
        err_msg = subject.create_assistant(model, instructions)
        expect(err_msg).to eq "model_not_found"
      end
    end

    context "when RestClient raises an exception" do
      it "returns the error code" do
        model = "gpt-3.5-turbo"
        instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
        expect(RestClient).to receive(:post).and_raise(RestClient::ExceptionWithResponse.new(double(code: 500, body: '{"error": {"code": "internal_server_error"}}')))
        err_msg = subject.create_assistant(model, instructions)
        expect(err_msg).to eq "internal_server_error"
      end
    end
  end

  describe ".retrieve_assistant" do
    context "with valid assistant_id" do
      it "retrieves the assistant" do
        assistant_id = "assistant_id"
        expect(RestClient).to receive(:get).and_return(double(code: 200, body: '{"id": "assistant_id"}'))
        assistant = subject.retrieve_assistant(assistant_id)
        expect(assistant.id).to eq "assistant_id"
      end
    end

    context "with invalid assistant_id" do
      it "raises an error" do
        assistant_id = "invalid_id"
        expect(RestClient).to receive(:get).and_return(double(code: 404, body: '{"error": {"code": "assistant_not_found"}}'))
        err_msg = subject.retrieve_assistant(assistant_id)
        expect(err_msg).to eq "assistant_not_found"
      end
    end

    context "when RestClient raises an exception" do
      it "returns the error code" do
        assistant_id = "assistant_id"
        expect(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(double(code: 500, body: '{"error": {"code": "internal_server_error"}}')))
        err_msg = subject.retrieve_assistant(assistant_id)
        expect(err_msg).to eq "internal_server_error"
      end
    end
  end

  describe ".delete_assistant" do
    context "with valid assistant_id" do
      it "deletes the assistant" do
        assistant_id = "assistant_id"
        expect(RestClient).to receive(:delete).and_return(double(code: 200, body: '{"deleted": true}'))
        result = subject.delete_assistant(assistant_id)
        expect(result).to eq true
      end
    end

    context "with invalid assistant_id" do
      it "raises an error" do
        assistant_id = "invalid_id"
        expect(RestClient).to receive(:delete).and_return(double(code: 404, body: '{"error": {"code": "assistant_not_found"}}'))
        err_msg = subject.delete_assistant(assistant_id)
        expect(err_msg).to eq "assistant_not_found"
      end
    end

    context "when RestClient raises an exception" do
      it "returns the error code" do
        assistant_id = "assistant_id"
        expect(RestClient).to receive(:delete).and_raise(RestClient::ExceptionWithResponse.new(double(code: 500, body: '{"error": {"code": "internal_server_error"}}')))
        err_msg = subject.delete_assistant(assistant_id)
        expect(err_msg).to eq "internal_server_error"
      end
    end
  end

  describe ".list_assistant" do
    context "with valid parameters" do
      it "returns a list of assistants" do
        expect(RestClient).to receive(:get).and_return(double(code: 200, body: '{"data": [{"id": "assistant_id"}]}'))
        assistants = subject.list_assistant
        expect(assistants.size).to be > 0
        expect(assistants[0]["id"]).to eq "assistant_id"
      end
    end

    context "when RestClient raises an exception" do
      it "returns the error code" do
        expect(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(double(code: 500, body: '{"error": {"code": "internal_server_error"}}')))
        err_msg = subject.list_assistant
        expect(err_msg).to eq "internal_server_error"
      end
    end
  end
end
