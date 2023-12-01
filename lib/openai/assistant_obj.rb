# frozen_string_literal: true

module Openai
  # A object model struct of assistant
  class AssistantObj
    # @return [String] The identifier, which can be referenced in API endpoints.
    attr_accessor :id
    # @return [String] The object type, which is always assistant.
    attr_accessor :object
    # @return [Integer] The Unix timestamp (in seconds) for when the assistant was created.
    attr_accessor :created_at
    # @return [String] The name of the assistant. The maximum length is 256 characters.
    attr_accessor :name
    # @return [String] The description of the assistant. The maximum length is 512 characters.
    attr_accessor :description
    # @return [String] ID of the model to use. Use the List models API to see all available models
    attr_accessor :model
    # @return [String] The system instructions that the assistant uses. The maximum length is 32768 characters.
    attr_accessor :instructions
    # @return [String] A list of tool enabled on the assistant.
    attr_accessor :tools
    # @return [String] A list of file IDs attached to this assistant.
    attr_accessor :file_ids
    # @return [String] Set of 16 key-value pairs that can be attached to an object.
    attr_accessor :metadata

    def initialize(**args)
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.from_json(data)
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
