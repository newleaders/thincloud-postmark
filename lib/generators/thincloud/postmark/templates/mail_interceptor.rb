# Public: Mail Interceptor to use when overriding defaults
class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "#{ENV["USER"]}@newleaders.com"
    message.bcc = nil
  end
end
