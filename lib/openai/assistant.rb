# frozen_string_literal: true

require_relative "assistant/version"
require_relative "assistant_obj"
require "uri"
require "json"
require "net/http"
require "rest-client"
module Openai
  # An openai assistant
  class Assistant
    @openai_api_key = nil
    @openai_url = nil

    # @param api_key [String] The api key of openai
    def initialize(api_key = "")
      @openai_api_key = api_key
      # hard the host because if the official docs change the host, maybe it will change another
      # we need to update this gem for any change
      @openai_url = "https://api.openai.com/v1/assistants"
    end

    # @param api_key [String] The api key of openai
    def self.setup(api_key = "")
      @openai_api_key = api_key
      # hard the host because if the official docs change the host, maybe it will change another
      # we need to update this gem for any change
      @openai_url = "https://api.openai.com/v1/assistants"
    end

    # @param model [String] Select model of the assistant. refer on: https://platform.openai.com/docs/api-reference/models/list.
    # @param instructions [String] The system instructions that the assistant uses.
    # @return [Openai::AssistantObj] A new response object of assistant.
    def create_assistant(model, instructions)
      url = @openai_url
      headers = {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
      req_body = {
        "instructions": instructions,
        "name": "assistant",
        "tools": [{ "type": "code_interpreter" }],
        "model": model
      }
      begin
        resp = RestClient.post(url, req_body.to_json, headers)
      rescue RestClient::ExceptionWithResponse => e
        resp = e.response
      end
      unless resp.code == 200
        parsed = JSON.parse(resp.body)
        return parsed["error"]["code"]
      end
      parse_assistant_object(JSON.parse(resp.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [Openai::AssistantObj] A new response object of assistant.
    def retrieve_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      headers = {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
      begin
        resp = RestClient.get(url, headers)
      rescue RestClient::ExceptionWithResponse => e
        resp = e.response
      end
      unless resp.code == 200
        parsed = JSON.parse(resp.body)
        return parsed["error"]["code"]
      end
      parse_assistant_object(JSON.parse(resp.body))
    end

    # @param assistant_id [String] The id of assistant after create
    # @return [String] Message delete the assistant ok or not
    def delete_assistant(assistant_id)
      url = "#{@openai_url}/#{assistant_id}"
      headers = {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
      begin
        resp = RestClient.delete(url, headers)
      rescue RestClient::ExceptionWithResponse => e
        resp = e.response
      end
      parsed = JSON.parse(resp.body)
      return parsed["error"]["code"] unless resp.code == 200

      parsed["deleted"]
    end

    # @return [Array<Openai::AssistantObj>] List all assistant
    def list_assistant
      url = @openai_url
      headers = {
        "Authorization": "Bearer #{@openai_api_key}",
        "OpenAI-Beta": "assistants=v1",
        "Content-Type": "application/json"
      }
      begin
        resp = RestClient.get(url, headers)
      rescue RestClient::ExceptionWithResponse => e
        resp = e.response
      end
      parsed = JSON.parse(resp.body)
      return parsed["error"]["code"] unless resp.code == 200

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
  end
end
