# frozen_string_literal: true

module Openai
  # Base class of openai
  class Base
    @openai_api_key = nil
    @openai_url = nil

    def initialize(api_key = "")
      @openai_api_key = api_key
      # hard the host because if the official docs change the host, maybe it will change another
      # we need to update this gem for any change
      @openai_url = "https://api.openai.com/v1/assistants"
    end
  end
end
