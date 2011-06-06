

ActionMailer::Base.smtp_settings = {
  :address              => "127.0.0.1",
  :port                 => 25,
  :domain               => "hankwilliams3.tcktcrckt.com",
  :authentication       => :none,
  :enable_starttls_auto => false
}
