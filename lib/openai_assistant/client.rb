# frozen_string_literal: true

module Openai
  module Assistant
    # An openai assistant client
    class Client
      attr_accessor :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def create_assistant(model, instructions)
        Openai::Assistant::Create.new(@api_key).create_assistant(model, instructions)
      end

      def retrieve_assistant(assistant_id)
        Openai::Assistant::Retrieve.new(@api_key).retrieve_assistant(assistant_id)
      end

      def list_assistant
        Openai::Assistant::List.new(@api_key).list_assistant
      end

      def delete_assistant(assistant_id)
        Openai::Assistant::Delete.new(@api_key).delete_assistant(assistant_id)
      end
    end
  end
end
