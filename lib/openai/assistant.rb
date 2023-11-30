# frozen_string_literal: true

require_relative "assistant/version"
require_relative "assistant_obj"
require_relative "base"
require_relative "../http/http"
require "json"
require "net/http"
require "uri"

module Openai
  # An openai assistant
  class Assistant < Base
    # @param api_key [String] The api key of openai\
    def initialize(api_key = "")
      super(api_key)
    end

    # @param api_key [String] The api key of openai
    def self.setup(api_key = "")
      initialize(api_key)
    end

    # @param model [String] Select model of the assistant. refer on: https://platform.openai.com/docs/api-reference/models/list.
    # @param instructions [String] The system instructions that the assistant uses.
    # @return [Openai::AssistantObj] A new response object of assistant.
    def create_assistant(model, instructions)
      url = URI.parse(@openai_url)
      req_body = {
        "instructions": instructions,
        "name": "assistant",
        "tools": [{ "type": "code_interpreter" }],
        "model": model
      }.to_json
      response = @http_client.call_post(url, req_body, default_headers)
      unless response.code == "200"
        parsed = JSON.parse(response.body)
        return parsed["error"]["code"]
      end
      parse_assistant_object(JSON.parse(response.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [Openai::AssistantObj] A new response object of assistant.
    def retrieve_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      uri = URI(url)
      response = @http_client.call_get(uri, default_headers)
      unless response.code == "200"
        parsed = JSON.parse(response.body)
        return parsed["error"]["code"]
      end
      parse_assistant_object(JSON.parse(response.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [String] Message delete the assistant ok or not
    def delete_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      uri = URI(url)
      response = @http_client.call_delete(uri, default_headers)
      parsed = JSON.parse(response.body)
      return parsed["error"]["code"] unless response.code == "200"

      parsed["deleted"]
    end

    # @return [Array<Openai::AssistantObj>] List all assistant
    def list_assistant
      url = @openai_url
      uri = URI(url)
      response = @http_client.call_get(uri, default_headers)
      parsed = JSON.parse(response.body)
      return parsed["error"]["code"] unless response.code == "200"

      assistants = []
      parsed["data"].each do |ast|
        assistants << parse_assistant_object(ast)
      end
    end

    private

    def parse_assistant_object(data)
      Openai::AssistantObj.new(
        id: data["id"],
        object: data["object"],
        created_at: data["created_at"],
        name: data["name"],
        description: data["description"],
        model: data["model"],
        instructions: data["instructions"],
        tools: data["tools"],
        file_ids: data["file_ids"],
        metadata: data["metadata"]
      )
    end

    def default_headers
      {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
    end
  end
end
