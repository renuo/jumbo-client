require "net/http"
require_relative "response"

module Jumbo
  class CouponsRequests
    def initialize(client = Client.new)
      @client = client
    end

    def create(coupons_request)
      @client.post_request("/api/lms/coupons_requests", {coupons_request: coupons_request.to_json})
    end
  end
end
