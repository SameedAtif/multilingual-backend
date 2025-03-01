DeepL.configure do |config|
  config.auth_key = ENV['DEEPL_AUTH_KEY']
  # config.host = 'https://api-free.deepl.com' # Default value is 'https://api.deepl.com'
  # config.version = 'v1' # Default value is 'v2'
end
