require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:interceptor) { Thincloud::Postmark::Interceptor }
  let(:interceptors) { ::Mail.class_variable_get(:@@delivery_interceptors) }

  describe "after Rails config" do
    it { interceptors.must_include Thincloud::Postmark::Interceptor }
    it { interceptor.to.must_match /newleaders/ }
    it { interceptor.bcc.must_be_nil }
  end
end
