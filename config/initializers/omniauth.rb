Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '125474050867821', '62316e062a23d81a5b0bfe25a15bc988', {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end