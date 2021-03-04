require "net/http"
require_relative "response"

module Jumbo
  class Employees
    def initialize(client = Client.new)
      @client = client
    end

    def index
      @client.get_request("/api/lms/partner/employees")
    end
  end
end
