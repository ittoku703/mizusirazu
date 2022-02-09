# set root path directory
root_path = File.expand_path('../../', __FILE__)

# set performance of application server
worker_processes 2

# set directory placed application
working_directory root_path

# set where the save the process ID
pid "#{root_path}/tmp/pids/unicorn.pid"

# set port number
listen "#{root_path}/tmp/sockets/unicorn.sock"

# set file of memorized error log
stderr_path "#{root_path}/log/unicorn.stderr.log"

# set file of memorized standard log
stdout_path "#{root_path}/log/unicorn.stdout.log"

# set timeout
timeout 30

# restart unicorn with no downtime
preload_app true

GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false
  end

  old_pid = "#{server.config[:pid]}/oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? QUIT : :TTOU
    rescue Errno::ENOENT, Errno::ESRCH => exception
      logger.error exception
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
