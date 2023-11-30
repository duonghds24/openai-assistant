# frozen_string_literal: true

# rubocop:disable Style/GlobalVars

RSpec.describe Openai::Assistant do
  $assistant = nil # keep the response after create for another method like retrieve, delete,...
  subject { described_class.new("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") } # need to use real api first to generate the vcr_cassettes with real data
  describe ".create_assistant" do
    context "with valid parameters" do
      it "creates an assistant" do
        VCR.use_cassette("create_assistant_valid") do
          model = "gpt-3.5-turbo"
          instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
          $assistant = subject.create_assistant(model, instructions)
          expect($assistant).to be_an_instance_of(Openai::AssistantObj)
          expect($assistant.id).to_not be_nil
        end
      end
    end

    context "with invalid model" do
      it "raises an error" do
        VCR.use_cassette("create_assistant_invalid") do
          model = "invalid_model"
          instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
          err_msg = subject.create_assistant(model, instructions)
          expect(err_msg).to eq "model_not_found"
        end
      end
    end
  end

  describe ".retrieve_assistant" do
    context "with valid assistant_id" do
      it "retrieves the assistant" do
        VCR.use_cassette("cretrieve_assistant_valid") do
          assistant_id = $assistant.id
          assistant = subject.retrieve_assistant(assistant_id)
          expect(assistant).to be_an_instance_of(Openai::AssistantObj)
          expect(assistant.id).to eq assistant_id
        end
      end
    end

    context "with invalid assistant_id" do
      it "raises an error" do
        VCR.use_cassette("retrieve_assistant_invalid") do
          assistant_id = "invalid_id"
          err_msg = subject.retrieve_assistant(assistant_id)
          expect(err_msg).to eq nil
        end
      end
    end
  end

  describe ".list_assistant" do
    context "with valid parameters" do
      it "returns a list of assistants" do
        VCR.use_cassette("list_assistant_valid") do
          assistants = subject.list_assistant
          expect(assistants.size).to be > 0
          expect(assistants[0]["id"]).to eq $assistant.id
        end
      end
    end
  end

  describe ".delete_assistant" do
    context "with valid assistant_id" do
      it "deletes the assistant" do
        VCR.use_cassette("delete_assistant_valid") do
          assistant_id = $assistant.id
          result = subject.delete_assistant(assistant_id)
          expect(result).to eq true
        end
      end
    end

    context "with invalid assistant_id" do
      it "raises an error" do
        VCR.use_cassette("delete_assistant_invalid") do
          assistant_id = "invalid_id"
          err_msg = subject.delete_assistant(assistant_id)
          expect(err_msg).to eq nil
        end
      end
    end
  end
end
# rubocop:enable Style/GlobalVars
