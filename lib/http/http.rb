# frozen_string_literal: true

require "net/http"
require "json"

module Http
  # An http client
  class Client
    def call_post(url, req_body, headers)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(url.path, headers)
      request.body = req_body unless req_body.nil?
      http.request(request)
    end

    def call_delete(url, headers)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Delete.new(url.path, headers)
      http.request(request)
    end

    def call_get(url, headers)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url.path, headers)
      http.request(request)
    end
  end
end
