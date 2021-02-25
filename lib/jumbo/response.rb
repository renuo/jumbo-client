require "json"
require "net/http/status"

module Jumbo
  class Response
    attr_accessor :json, :code

    def self.from(response)
      new(JSON.parse(response.body, symbolize_names: true), response.code.to_i)
    end

    def initialize(json, code)
      @json = json
      @code = code.to_i
    end

    Hash[*Net::HTTP::STATUS_CODES.map { |code, message|
      [message.downcase.gsub(/\s|-|'/, "_").to_sym, code]
    }.flatten].each do |(symbol, status_code)|
      define_method "#{symbol}?" do
        @code == status_code
      end
    end

    def success?
      @code.between?(200, 299)
    end
  end
end
