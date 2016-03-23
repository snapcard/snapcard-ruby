module Snapcard
  class Client
    require 'net/http'
    require 'uri'
    require 'json'
    require 'openssl'

    API_BASE_URL = 'https://api.snapcard.io/'
    API_VERSION = '2'

    def initialize options
      raise "api_key and secret_key required" unless options[:api_key] && options[:secret_key]
      @options = options
    end

    def post options
      make_request Net::HTTP::Post, options
    end

    def get options
      make_request Net::HTTP::Get, options
    end

    def put options
      make_request Net::HTTP::Put, options
    end

    def delete options
      make_request Net::HTTP::Delete, options
    end

    private

    def make_request http_generic_request_class, options
      raise "Please specify path" unless options[:path]
      path = options[:path]
      options.delete :path
      params = options
      request = assemble_request http_generic_request_class, path, params
      send_request request
    end

    def assemble_request http_generic_request_class, path, params
      uri = URI.parse API_BASE_URL + path
      uri.query = build_query http_generic_request_class, params
      request = http_generic_request_class.new uri
      body = http_generic_request_class == Net::HTTP::Get ? {} : params
      request.body = body.to_json if !body.empty?
      headers = generate_headers uri, body
      headers.each do |key, value|
        request.add_field key, value
      end
      request
    end

    def build_query http_generic_request_class, params
      timestamp = (Time.now.to_f * 1000).to_i
      query = {:timestamp => timestamp}
      query.merge! params if http_generic_request_class == Net::HTTP::Get
      URI.encode_www_form query
    end

    def send_request request
      http = Net::HTTP.new request.uri.host, request.uri.port
      http.use_ssl = true
      http.read_timeout = @options[:read_timeout] || 20
      http.request request
    end

    def generate_headers uri, body={}
      signature = generate_signature uri, body
      headers = {
        'X-Api-Key' => @options[:api_key],
        'X-Api-Signature' => signature,
        'X-Api-Version' => API_VERSION,
        'Content-Type' => "application/json"
      }
      headers
    end

    def generate_signature uri, body={}
      body_s = body.empty? ? "" : body.to_json.to_s
      to_sign = uri.to_s + body_s
      OpenSSL::HMAC.hexdigest OpenSSL::Digest::SHA256.new, @options[:secret_key], to_sign
    end
  end
end
