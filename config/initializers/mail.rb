# Configuração global de SSL para evitar erros de certificado
# Especialmente útil para macOS com problemas de verificação de certificado CRL

Rails.application.config.after_initialize do
  ActionMailer::Base.smtp_settings[:openssl_verify_mode] = OpenSSL::SSL::VERIFY_NONE if ActionMailer::Base.smtp_settings
end
