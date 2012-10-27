require "minitest_helper"

describe Thincloud::Postmark::Configuration do
  let(:config) { Thincloud::Postmark::Configuration.new }

  it { config.must_be_kind_of Thincloud::Postmark::Configuration }
  it { config.must_respond_to :api_key }
  it { config.must_respond_to :api_key= }
  it { config.must_respond_to :secure }
  it { config.must_respond_to :secure= }

  describe "defaults" do
    it { config.api_key.must_equal "POSTMARK_API_TEST" }
    it { config.secure.must_equal true }
    it { ::Postmark.secure.must_equal true }
  end

  describe "changes Postmark secure setting" do
    before do
      @original_setting = ::Postmark.secure
      config.secure = false
    end

    after { ::Postmark.secure = @original_setting }

    it { config.secure.must_equal false }
    it { ::Postmark.secure.must_equal false }
  end
end