require "minitest_helper"

describe Dummy::Application.config do
  let(:config) { Dummy::Application.config.thincloud.postmark }

  # defaults
  it { config.must_be_kind_of Thincloud::Postmark::Configuration }
  it { config.api_key.must_equal "INITIALIZER" }

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
      @original_setting = config.secure

      Thincloud::Postmark.configure do |config|
        config.secure = false
      end
    end

    after { config.secure = @original_setting }

    it { config.secure.must_equal false }
    it { ::Postmark.secure.must_equal false }
  end

  describe "updates Rails application configuration" do
    let(:app_config) { Dummy::Application.config.action_mailer }
    let(:settings) { { api_key: "INITIALIZER" } }

    it { app_config.delivery_method.must_equal :postmark }
    it { app_config.postmark_settings.must_equal settings }
  end

  describe "updates ActionMailer configuration" do
    let(:base_config) { ActionMailer::Base }
    let(:settings) { { api_key: "INITIALIZER" } }

    it { base_config.delivery_method.must_equal :postmark }
    it { base_config.postmark_settings.must_equal settings }
  end
end
