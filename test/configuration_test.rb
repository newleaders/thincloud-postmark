require "minitest_helper"

describe Thincloud::Postmark::Configuration do

  describe "api_key" do
    describe "default" do
      it { Thincloud::Postmark::Configuration.new.api_key.must_equal "POSTMARK_API_TEST" }
    end

    describe "provided" do
      before do
        Thincloud::Postmark.configure do |config|
          config.api_key = "abc123"
        end
      end

      it { Thincloud::Postmark.configuration.api_key.must_equal "abc123" }
    end
  end

end
