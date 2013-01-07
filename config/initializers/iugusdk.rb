IuguSDK.setup do |config|
  config.app_main_url = '/'
  config.application_title = 'iugu-playground'

  config.enable_multiple_accounts = false

  config.enable_account_alias = false
  config.enable_custom_domain = false
  config.enable_social_login = false
  config.enable_social_linking = false
  config.enable_user_confirmation = false
  config.enable_email_reconfirmation = true
  config.enable_subscription_features = false
  config.enable_account_api = true
  config.enable_guest_user = false
  config.enable_user_api = true

  # config.alternative_layout = 'forms'

  # Application Host
  config.application_main_host = 'iugu-playground.dev'
end
