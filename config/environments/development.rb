Illusion::Application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.assets.debug = true

  config.action_mailer.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "gmail.com",
    :authentication => "plain",
    :user_name => "mailer778@gmail.com",
    :password => "gfhjkm8712",
    :enable_starttls_auto => true
  }
end
