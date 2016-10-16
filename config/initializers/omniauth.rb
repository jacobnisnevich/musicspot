OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '134132943719526', 'b643453b3f29c78d15f7ad89afca75c3', {client_options: {:ssl => {:verify => false}}}
end