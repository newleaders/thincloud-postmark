require "minitest_helper"

describe Thincloud::Postmark::Configuration do
  let(:config) { Dummy::Application.config.thincloud.postmark }

  # defaults
  it { config.must_be_kind_of Thincloud::Postmark::Configuration }
  it { config.api_key.must_equal "POSTMARK_API_TEST" }
  it { config.secure.must_equal true }
  it { ::Postmark.secure.must_equal true }

  describe "with configure block" do
    before do
      Thincloud::Postmark.configure do |config|
        config.api_key = "abc123"
      end
    end

    it { config.api_key.must_equal "abc123" }
  end

  describe "changes Postmark secure setting" do
    before do
      Thincloud::Postmark.configure do |config|
        config.secure = false
      end
    end

    it { config.secure.must_equal false }
    it { ::Postmark.secure.must_equal false }
  end

  describe "updates Rails application configuration" do
    let(:app_config) { Dummy::Application.config.action_mailer }
    let(:settings) { { api_key: "POSTMARK_API_TEST" } }

    it { app_config.delivery_method.must_equal :postmark }
    it { app_config.postmark_settings.must_equal settings }
  end
end
