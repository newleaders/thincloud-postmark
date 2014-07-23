require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:mail) { OpenStruct.new(to: "rpeck@epa.gov", subject: "Subject") }
  let(:interceptor) { Thincloud::Postmark::Interceptor }

  it { interceptor.must_respond_to(:to) }
  it { interceptor.must_respond_to(:to=) }
  it { interceptor.must_respond_to(:cc) }
  it { interceptor.must_respond_to(:cc=) }
  it { interceptor.must_respond_to(:bcc) }
  it { interceptor.must_respond_to(:bcc=) }
  it { interceptor.must_respond_to(:delivering_email) }

  describe "munges the subject" do
    before do
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.subject.must_equal "[rpeck@epa.gov] Subject" }
  end

  describe "sets email `to`" do
    before do
      interceptor.to = "egon@ghostbusters.com"
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.to.must_equal "egon@ghostbusters.com" }
  end

  describe "sets email `cc`" do
    before do
      interceptor.cc = "venkman@ghostbusters.com"
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.cc.must_equal "venkman@ghostbusters.com" }
  end

  describe "sets email `bcc`" do
    before do
      interceptor.bcc = "stantz@ghostbusters.com"
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.bcc.must_equal "stantz@ghostbusters.com" }
  end
end
