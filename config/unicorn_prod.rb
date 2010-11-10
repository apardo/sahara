worker_processes 2
working_directory "/home/saharaapp/sahara/current"
listen "/tmp/sahara.socket", :backlog => 64
timeout 30
user 'saharaapp', 'saharaapp'
shared_path = "/home/saharaapp/sahara/current/tmp"
pid "#{shared_path}/pids/unicorn.pid"
stderr_path "/home/saharaapp/sahara/current/log/unicorn.stderr.log"
stdout_path "/home/saharaapp/sahara/current/log/unicorn.stdout.log"
