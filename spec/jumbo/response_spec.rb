require "dotenv/load"

RSpec.describe Jumbo::Response do
  subject(:response) { described_class.new({}, response_code) }

  describe "http status methods" do
    context "when the response_code is 200" do
      let(:response_code) { 200 }

      it { is_expected.to be_ok }
      it { is_expected.to be_success }
    end

    context "when the response_code is '200' (as string)" do
      let(:response_code) { "200" }

      it { is_expected.to be_ok }
    end

    context "when the response_code is 404" do
      let(:response_code) { 404 }

      it { is_expected.to be_not_found }
      it { is_expected.not_to be_success }
    end
  end
end
