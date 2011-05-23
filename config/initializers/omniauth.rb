Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '215260161819659', '34cab5d5c198b5ee15c1fcd2e3e96305'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end