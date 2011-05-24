Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '224771314202672', '00eaecfb8f7667a2b3017c89121e76c8'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end