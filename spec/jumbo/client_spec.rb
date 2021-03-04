require "dotenv/load"
require "jumbo/coupons_request"

RSpec.describe Jumbo::Client do
  let(:instance) { described_class.new(test: true) }

  describe "#ping" do
    it "can ping the jumbo services" do
      response = instance.ping
      expect(response).to be_ok
      expect(response.json).to eq({})
    end
  end

  describe "#coupons_requests" do
    it "generates a request for coupons" do
      event_type = "new_mastercard_request"
      request = Jumbo::CouponsRequest.new(coupon_assignment_event_type: event_type, loyalty_code: "1234567890")
      response = instance.coupons_requests.create(request)
      expect(response).to be_created
      expect(response.json).to match a_hash_including(coupons_request: a_hash_including(
        coupon_assignment_event_type: event_type,
        loyalty_code: "1234567890",
        coupons: be_a(Array)
      ))
    end
  end

  describe "#employees" do
    it "retrieves a list of employees" do
      response = instance.employees.index
      expect(response).to be_ok
      expect(response.json[:employees].length).to be > 0
      expect(response.json[:employees].first)
        .to match a_hash_including(:id, :first_name, :last_name, :email, :promo_code, :reference_code, :shop_id)
    end
  end
end
