require "minitest_helper"

describe Dummy::Application.config do
  let(:config) do
    Dummy::Application.config.thincloud.postmark
  end

  # defaults
  specify { config.must_be_kind_of Thincloud::Postmark::Configuration }
  specify { config.api_key.must_equal "INITIALIZER" }

  describe "with configure block" do
    before do
      Thincloud::Postmark.configure do |config|
        config.api_key = "abc123"
      end
    end

    specify { config.api_key.must_equal "abc123" }
  end

  describe "changes Postmark secure setting" do
    before do
      @original_setting = config.secure

      Thincloud::Postmark.configure do |config|
        config.secure = false
      end
    end

    after do
      config.secure = @original_setting
    end

    specify { config.secure.must_equal false }
    specify { ::Postmark.secure.must_equal false }
  end

  describe "configuration updates" do
    let(:settings) do
      { api_key: "INITIALIZER" }
    end

    [Dummy::Application.config.action_mailer, ActionMailer::Base].each do |conf|
      specify { conf.delivery_method.must_equal :postmark }
      specify { conf.postmark_settings.must_equal settings }
    end
  end
end
