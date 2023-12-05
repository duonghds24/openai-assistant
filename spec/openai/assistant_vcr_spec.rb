# frozen_string_literal: true

# RSpec.describe OpenaiAsissistant::Assistant::Client do
#   subject { described_class.new("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") } # need to use real api first to generate the vcr_cassettes with real data
#   let(:model) { "gpt-3.5-turbo" }
#   let(:instructions) { "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question." }
#   let(:assistant) do # keep the response after create for another method like retrieve, delete,...
#     VCR.use_cassette("create_sample_assistant") do
#       subject.create_assistant(model, instructions)
#     end
#   end
#   before do
#     assistant
#   end

#   describe "#create_assistant" do
#     context "with valid parameters" do
#       it "creates an assistant" do
#         VCR.use_cassette("create_assistant_valid") do
#           model = "gpt-3.5-turbo"
#           instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
#           ast = subject.create_assistant(model, instructions)
#           expect(ast).to be_an_instance_of(OpenaiAsissistant::Mapper::Assistant)
#           expect(ast.id).to_not be_nil
#         end
#       end
#     end

#     context "with invalid model" do
#       it "raises an error" do
#         VCR.use_cassette("create_assistant_invalid") do
#           model = "invalid_model"
#           instructions = "You are a personal math tutor. When asked a question, write and run Ruby code to answer the question."
#           err_resp = subject.create_assistant(model, instructions)
#           expect(err_resp.code).to eq "model_not_found"
#         end
#       end
#     end
#   end

#   describe "#retrieve_assistant" do
#     context "with valid assistant_id" do
#       it "retrieves the assistant" do
#         VCR.use_cassette("cretrieve_assistant_valid") do
#           assistant_id = assistant.id
#           ast = subject.retrieve_assistant(assistant_id)
#           expect(ast).to be_an_instance_of(OpenaiAsissistant::Mapper::Assistant)
#           expect(ast.id).to eq assistant_id
#         end
#       end
#     end

#     context "with invalid assistant_id" do
#       it "raises an error" do
#         VCR.use_cassette("retrieve_assistant_invalid") do
#           assistant_id = "invalid_id"
#           err_resp = subject.retrieve_assistant(assistant_id)
#           expect(err_resp.code).to eq nil
#         end
#       end
#     end
#   end

#   describe "#list_assistant" do
#     context "with valid parameters" do
#       it "returns a list of assistants" do
#         VCR.use_cassette("list_assistant_valid") do
#           assistants = subject.list_assistant
#           expect(assistants.size).to be > 0
#         end
#       end
#     end
#   end

#   describe "#delete_assistant" do
#     context "with valid assistant_id" do
#       it "deletes the assistant" do
#         VCR.use_cassette("delete_assistant_valid") do
#           assistant_id = assistant.id
#           result = subject.delete_assistant(assistant_id)
#           expect(result).to eq true
#         end
#       end
#     end

#     context "with invalid assistant_id" do
#       it "raises an error" do
#         VCR.use_cassette("delete_assistant_invalid") do
#           assistant_id = "invalid_id"
#           err_resp = subject.delete_assistant(assistant_id)
#           expect(err_resp.code).to eq nil
#         end
#       end
#     end
#   end
# end
