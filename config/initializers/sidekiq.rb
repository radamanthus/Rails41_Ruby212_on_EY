# Figure out the Redis host from redis.yml
redis_config = YAML.load_file('config/redis.yml')[Rails.env]
host = redis_config["host"]
port = redis_config["port"]

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}" }
end

# Setup self-terminating sidekiqs
Seppuqu.install
# module Sidekiq
#   def self.current_release_version
#     @current_release_version ||= File.expand_path(__FILE__).scan(/\d{10,}/).map(&:to_i)[0] || -1
#   end
#
#   def self.latest_release_version
#     Sidekiq.redis do |conn|
#       conn.get("release_version") || -1
#     end.to_i
#   end
#
#   module Middleware
#     class VersionEnforcerMiddleware
#       def call(worker, msg, queue)
#         lrv, crv = Sidekiq.latest_release_version, Sidekiq.current_release_version
#         if lrv <= crv
#           yield
#         elsif
#           Sidekiq.logger.info "My version (#{crv}) mismatches latest version (#{lrv}). Shutting down..."
#           Thread.main.raise Interrupt
#         end
#       end
#     end
#   end
# end
#
# Sidekiq.configure_server do |config|
#   config.server_middleware do |chain|
#     chain.add Sidekiq::Middleware::VersionEnforcerMiddleware
#   end
# end

Seppuqu.update_release_version
# Sidekiq.redis {|c| c.set "release_version", Sidekiq.current_release_version }
