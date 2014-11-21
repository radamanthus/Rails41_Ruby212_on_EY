Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://ip-10-231-191-5:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://ip-10-231-191-5:6379' }
end
