require "dotenv/load"

RSpec.describe Jumbo::Client do
  describe "#ping" do
    let(:instance) { described_class.new(test: true) }

    it "can ping the jumbo services" do
      response = instance.ping
      expect(response).to be_ok
      expect(response.json).to eq({})
    end
  end
end
