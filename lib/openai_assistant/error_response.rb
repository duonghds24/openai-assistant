# frozen_string_literal: true

module OpenaiAssistant
  # A error response of openai
  class ErrorResponse
    # @return [String] error message
    attr_accessor :message
    # @return [String] type of error
    attr_accessor :type
    # @return [String] parameter that caused the error
    attr_accessor :param
    # @return [String] error code of openai
    attr_accessor :code

    def initialize(**args)
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.from_json(response_body)
      data = JSON.parse(response_body)["error"]
      OpenaiAssistant::ErrorResponse.new(
        message: data["message"],
        type: data["type"],
        param: data["param"],
        code: data["code"]
      )
    end
  end
end
