class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    puts "Working hard!"
    sleep 1
  end
end
