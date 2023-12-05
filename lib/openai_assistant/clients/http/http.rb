# frozen_string_literal: true

module Openai
  # An http client
  class HTTPClient
    # disable_ssl instead of ssl because almost the host is https
    def call_post(url, req_body, headers, disable_ssl: false)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = disable_ssl ? false : true
      request = Net::HTTP::Post.new(url.path, headers)
      request.body = req_body unless req_body.nil?
      http.request(request)
    end

    def call_delete(url, headers, disable_ssl: false)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = disable_ssl ? false : true
      request = Net::HTTP::Delete.new(url.path, headers)
      http.request(request)
    end

    def call_get(url, headers, disable_ssl: false)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = disable_ssl ? false : true
      request = Net::HTTP::Get.new(url.path, headers)
      http.request(request)
    end
  end
end
