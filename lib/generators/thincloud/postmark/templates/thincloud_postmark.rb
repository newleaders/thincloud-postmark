Thincloud::Postmark.configure do |config|
  config.api_key = ENV["POSTMARK_API_KEY"] || "POSTMARK_API_TEST"
end
