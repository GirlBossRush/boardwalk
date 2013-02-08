if ENV["RAILS_ENV"] == "development"
  worker_processes 1
  timeout 10000
else
  worker_processes 3
  timeout 30
end

preload_app true

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end

  sleep 1
end

after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis = ENV['REDIS_URI']
    Rails.logger.info('Connected to Redis')
  end
end
