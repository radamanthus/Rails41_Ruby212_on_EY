# Update release_version in Redis

require 'yaml'
require 'redis'

rails_env = config.framework_env
redis_config = YAML.load_file('config/redis.yml')[rails_env]
host = redis_config['host']
port = redis_config['port']

current_version = File.expand_path(__FILE__).scan(/\d{10,}/).map(&:to_i)[0] || -1
conn = Redis.new(host: host, port: port)
conn.set "release_version", current_version

class DummyWorker
  include Sidekiq::Worker
  def perform
  end
end
DummyWorker.perform_async
