# frozen_string_literal: true

require_relative "assistant/version"
require_relative "assistant_obj"
require_relative "base"
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
      puts default_headers
      url = URI.parse(@openai_url)
      req_body = {
        "instructions": instructions,
        "name": "assistant",
        "tools": [{ "type": "code_interpreter" }],
        "model": model
      }.to_json
      response = call_post(url, req_body)
      return response["error"]["code"] unless response["error"].nil?

      parse_assistant_object(JSON.parse(response.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [Openai::AssistantObj] A new response object of assistant.
    def retrieve_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      uri = URI(url)
      response = call_post(uri, nil)
      return response["error"]["code"] unless response["error"].nil?

      parse_assistant_object(JSON.parse(response.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [String] Message delete the assistant ok or not
    def delete_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      uri = URI(url)
      response = call_post(uri, nil)
      return response["error"]["code"] unless response["error"].nil?

      parsed = JSON.parse(response.body)

      parsed["deleted"]
    end

    # @return [Array<Openai::AssistantObj>] List all assistant
    def list_assistant
      url = @openai_url
      uri = URI(url)
      response = call_get(uri)
      return response["error"]["code"] unless response["error"].nil?

      parsed = JSON.parse(response.body)
      assistants = []
      parsed["data"].each do |ast|
        assistants << parse_assistant_object(ast)
      end
    end

    # @return private
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

    def call_post(url, req_body)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, default_headers)
      request.body = req_body
      response = http.request(request)
      parsed = JSON.parse(response.body)
      return parsed["error"]["code"] unless response.code == "200"

      parsed
    end

    def call_get(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path, default_headers)
      response = http.request(request)
      parsed = JSON.parse(response.body)
      return parsed["error"]["code"] unless response.code == "200"

      parsed
    end
  end
end
