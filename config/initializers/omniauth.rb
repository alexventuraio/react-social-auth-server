OmniAuth.config.logger = Rails.logger
# Addresses https://nvd.nist.gov/vuln/detail/CVE-2015-9284
OmniAuth.config.allowed_request_methods = [:post]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end
