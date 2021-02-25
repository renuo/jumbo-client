require "net/http"
require_relative "response"
require "active_model"

module Jumbo
  class CouponsRequest
    include ActiveModel::Model

    attr_accessor :ean, :coupon_assignment_event_type, :loyalty_code

    def to_json(*_args)
      {
        ean: ean,
        coupon_assignment_event_type: coupon_assignment_event_type,
        loyalty_code: loyalty_code
      }
    end
  end
end
