if Rails.env.production?
  Rails.application.config.action_mailer.default_url_options = { host: 'palpito.com.br' }
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.smtp_settings = {
    address:              ENV['SMTP_ADDRESS'],
    port:                 ENV['SMTP_PORT'],
    user_name:            ENV['SMTP_USER_NAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       ENV['SMTP_AUTHENTICATION'],
    enable_starttls_auto: ENV['SMTP_ENABLE_STARTTLS_AUTO'],
    openssl_verify_mode:  ENV['SMTP_OPENSSL_VERIFY_MODE'],
  }
else
  Rails.application.config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
