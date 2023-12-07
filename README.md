# OpenaiAsissistant::Assistant
This project/gem is for Ruby interact with OpenAI Assistant throught rest api.

The client to call is: `OpenaiAsissistant::Assistant`

## Installation
Install throught RubyGems server by below step:

`$ bundle add openai/assistant`.

`$ bundle install openai/assistant`

## Usage
You can direct interact with gem by:

- use the gem `require "openai/assistant"`
- setup the api key `instance =OpenaiAsissistant::Assistant::new(${API_KEY})`
- interact with assistant: 
    + `instance.create_assistant(model, instruction)` 

    + `instance.retrieve_assistant(assistant_id)` 

    + `instance.delete_assistant(assistant_id)` 

    + `instance.list_assistant()`

## Reference
- source: https://github.com/duonghds24/openai-assistant
- gem: https://rubygems.org/gems/openai-assistant
- document: https://www.rubydoc.info/gems/openai-assistant/