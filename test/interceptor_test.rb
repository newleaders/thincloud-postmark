require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:mail) do
    OpenStruct.new(to: "rpeck@epa.gov", subject: "Subject")
  end

  subject do
    Thincloud::Postmark::Interceptor
  end

  specify { subject.must_respond_to(:to) }
  specify { subject.must_respond_to(:to=) }
  specify { subject.must_respond_to(:cc) }
  specify { subject.must_respond_to(:cc=) }
  specify { subject.must_respond_to(:bcc) }
  specify { subject.must_respond_to(:bcc=) }
  specify { subject.must_respond_to(:delivering_email) }

  describe "munges the subject" do
    before do
      @msg = subject.delivering_email(mail)
    end

    specify { @msg.subject.must_equal "[rpeck@epa.gov] Subject" }
  end

  describe "sets email `to`" do
    before do
      subject.to = "egon@ghostbusters.com"
      subject.cc = "venkman@ghostbusters.com"
      subject.bcc = "stantz@ghostbusters.com"

      @msg = subject.delivering_email(mail)
    end

    specify { @msg.to.must_equal "egon@ghostbusters.com" }
    specify { @msg.cc.must_equal "venkman@ghostbusters.com" }
    specify { @msg.bcc.must_equal "stantz@ghostbusters.com" }
  end
end
