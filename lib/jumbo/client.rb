require "net/http"
require "jumbo"

module Jumbo
  class Client
    DEFAULT_TIMEOUT = 60 # in seconds

    attr_reader :api_key

    class NoLogger
      def call(_url, _request)
        yield
      end
    end

    def initialize(api_key: ENV["JUMBO_CLIENT_API_KEY"],
      test: false,
      base_url: nil,
      logger: NoLogger.new)
      @api_key = api_key
      @base_url = base_url || ENV["JUMBO_CLIENT_API_URL"] || (test ? "https://loyalty-jumbo-test.accarda.com/" : "https://loyalty-jumbo.accarda.com/")
      @logger = logger
    end

    def ping
      get_request("/api/lms/ping")
    end

    def coupons_requests
      @coupons_requests ||= CouponsRequests.new(self)
    end

    def employees
      @employees ||= Employees.new(self)
    end

    def get_request(path, params = nil)
      url = build_url(path)
      req = build_get_request(url, params)
      perform_request(url, req)
    end

    def post_request(path, params)
      url = build_url(path)
      request = build_post_request(url, params)
      perform_request(url, request)
    end

    protected

    def build_url(path)
      uri = @base_url.dup
      uri << "/" unless uri.end_with? "/"
      URI.join(URI.parse(uri), path)
    end

    def build_get_request(url, params)
      url.query = URI.encode_www_form(params) unless params.nil?
      Net::HTTP::Get.new(url).tap(&method(:header_params))
    end

    def build_post_request(url, params)
      Net::HTTP::Post.new(url.path).tap do |request|
        header_params(request)
        request.body = params.to_json
      end
    end

    def perform_request(url, request)
      http_new = Net::HTTP.new(url.hostname, url.port)
      manipulate_http_request(http_new)
      Response.from(@logger.call(url, request) { http_new.start { |http| http.request(request) } })
    end

    def manipulate_http_request(http_new)
      http_new.use_ssl = @base_url.start_with?("https")
      http_new.open_timeout = DEFAULT_TIMEOUT
      http_new.read_timeout = DEFAULT_TIMEOUT
    end

    def header_params(request)
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      request["Api-Key"] = @api_key
    end
  end
end
