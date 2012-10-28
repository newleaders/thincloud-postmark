require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:interceptor) { Thincloud::Postmark::Interceptor }
  let(:interceptors) { ::Mail.class_variable_get(:@@delivery_interceptors) }

  describe "after Rails config" do
    it { interceptors.must_include Thincloud::Postmark::Interceptor }
    it { interceptor.to.must_equal "marshmellowman@staypuft.com" }
    it { interceptor.cc.must_be_nil }
    it { interceptor.bcc.must_be_nil }
  end
end
