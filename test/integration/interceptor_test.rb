require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:interceptor) do
    Thincloud::Postmark::Interceptor
  end

  let(:interceptors) do
    ::Mail.class_variable_get(:@@delivery_interceptors)
  end

  describe "after Rails config" do
    specify { interceptors.must_include Thincloud::Postmark::Interceptor }
    specify { interceptor.to.must_equal "marshmellowman@staypuft.com" }
    specify { interceptor.cc.must_be_nil }
    specify { interceptor.bcc.must_be_nil }
  end
end
