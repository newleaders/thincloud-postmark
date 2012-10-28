require "minitest_helper"

describe Thincloud::Postmark::Interceptor do
  let(:mail) { OpenStruct.new(to: "e@example.com", subject: "Subject") }
  let(:interceptor) { Thincloud::Postmark::Interceptor }

  it { interceptor.must_respond_to(:to) }
  it { interceptor.must_respond_to(:to=) }
  it { interceptor.must_respond_to(:bcc) }
  it { interceptor.must_respond_to(:bcc=) }
  it { interceptor.must_respond_to(:delivering_email) }

  describe "munges the subject" do
    before do
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.subject.must_equal "e@example.com Subject" }
  end

  describe "sets email `to`" do
    before do
      interceptor.to = "egon@ghostbusters.com"
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.to.must_equal "egon@ghostbusters.com" }
  end

  describe "sets email `bcc`" do
    before do
      interceptor.bcc = "bcc@bcc.com"
      @msg = interceptor.delivering_email(mail)
    end

    it { @msg.bcc.must_equal "bcc@bcc.com" }
  end
end