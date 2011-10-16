rails_env = ENV['RAILS_ENV'] || 'production'
app_path = "/home/www/stmh"

worker_processes 2
working_directory app_path

preload_app true

timeout 30

listen 8888, :tcp_nopush => true
listen "#{app_path}/tmp/sockets/unicorn.sock", :backlog => 64
pid "#{app_path}/tmp/pids/unicorn.pid"

stderr_path "#{app_path}/log/unicorn.stderr.log"
stderr_path "#{app_path}/log/unicorn.stdout.log"

before_fork do |server, worker|
  #ActiveRecord::Base.connection.discounnect! if defined?(ActiveRecord::Base)
  old_pid = "#{app_path}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errono::ENOENT, Errno::ESRCH
      #
    end
  end
end

after_fork do |server, worker|
  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'www', 'www'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user"
    else
      raise e
    end
  end
end
