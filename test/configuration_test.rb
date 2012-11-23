require "minitest_helper"

describe Thincloud::Postmark::Configuration do
  let(:config) { Thincloud::Postmark::Configuration.new }

  it { config.must_be_kind_of Thincloud::Postmark::Configuration }
  it { config.must_respond_to :environments }
  it { config.must_respond_to :environments= }
  it { config.must_respond_to :api_key }
  it { config.must_respond_to :api_key= }
  it { config.must_respond_to :secure }
  it { config.must_respond_to :secure= }
  it { config.must_respond_to :interceptor_environments }
  it { config.must_respond_to :interceptor_to }
  it { config.must_respond_to :interceptor_to= }
  it { config.must_respond_to :interceptor_bcc }
  it { config.must_respond_to :interceptor_bcc= }

  describe "defaults" do
    it { config.environments.must_equal [] }
    it { config.api_key.must_equal "POSTMARK_API_TEST" }
    it { config.secure.must_equal true }
    it { ::Postmark.secure.must_equal true }
    it { config.interceptor_environments.must_equal [] }
    it { config.interceptor_to.must_be_nil }
    it { config.interceptor_cc.must_be_nil }
    it { config.interceptor_bcc.must_be_nil }
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
