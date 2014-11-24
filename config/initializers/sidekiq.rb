redis_config = YAML.load_file('config/redis.yml')[Rails.env]
host = redis_config["host"]
port = redis_config["port"]

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}" }
end
