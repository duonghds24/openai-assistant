# frozen_string_literal: true

require "net/http"
require "json"

module Http
  # An http client
  class Client
    def call_post(_url, req_body, headers)
      http = Net::HTTP.new(_url.host, _url.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(_url.path, headers)
      request.body = req_body unless req_body.nil?
      http.request(request)
    end

    def call_delete(_url, headers)
      http = Net::HTTP.new(_url.host, _url.port)
      http.use_ssl = true
      request = Net::HTTP::Delete.new(_url.path, headers)
      http.request(request)
    end

    def call_get(_url, headers)
      http = Net::HTTP.new(_url.host, _url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(_url.path, headers)
      http.request(request)
    end
  end
end
