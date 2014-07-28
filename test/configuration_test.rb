require "minitest_helper"

describe Thincloud::Postmark::Configuration do
  subject do
    Thincloud::Postmark::Configuration.new
  end

  specify { subject.must_be_kind_of Thincloud::Postmark::Configuration }
  specify { subject.must_respond_to :environments }
  specify { subject.must_respond_to :environments= }
  specify { subject.must_respond_to :api_key }
  specify { subject.must_respond_to :api_key= }
  specify { subject.must_respond_to :secure }
  specify { subject.must_respond_to :secure= }
  specify { subject.must_respond_to :interceptor_environments }
  specify { subject.must_respond_to :interceptor_to }
  specify { subject.must_respond_to :interceptor_to= }
  specify { subject.must_respond_to :interceptor_bcc }
  specify { subject.must_respond_to :interceptor_bcc= }

  describe "defaults" do
    specify { subject.environments.must_equal [] }
    specify { subject.api_key.must_equal "POSTMARK_API_TEST" }
    specify { subject.secure.must_equal true }
    specify { ::Postmark.secure.must_equal true }
    specify { subject.interceptor_environments.must_equal [] }
    specify { subject.interceptor_to.must_be_nil }
    specify { subject.interceptor_cc.must_be_nil }
    specify { subject.interceptor_bcc.must_be_nil }
  end

  describe "changes Postmark secure setting" do
    before do
      @original_setting = ::Postmark.secure
      subject.secure = false
    end

    after do
      ::Postmark.secure = @original_setting
    end

    specify { subject.secure.must_equal false }
    specify { ::Postmark.secure.must_equal false }
  end
end
