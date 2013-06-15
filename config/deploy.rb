set :application, "vps16564.ovh.net"
set :rvm_bin_path, "/root/.rvm/bin"

role :web, "#{application}"                           # Your HTTP server, Apache/etc
role :app, "#{application}"                           # This may be the same as your `Web` server
role :db,  "#{application}", :primary => true         # This is where Rails migrations will run

set :user, 'timebankuser'
set :domain, 'vps16564.ovh.net'
set :applicationdir, "time-bank"

set :deploy_to, "/var/www/time-bank"

default_run_options[:pty] = true # Must be set for the password prompt from git to work
set :repository, "git@github.com:jd-erreape/time-bank.git" # Your clone URL
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }


after 'deploy:update_code', 'bundler:new_release'
after 'deploy:rollback', 'bundler:symlink_vendor_rollback'

set :stage, "production" unless variables[:stage]

namespace :deploy do
  task :restart do
    run "cd #{current_path} && bundle exec thin stop"
    run "cd #{current_path} && bundle exec thin start -e #{stage} -d -p 3004"
  end
end

namespace :bundler do
  task :symlink_vendor_rollback do
    p "********************** BUNDLER:SYMLINK_ROLLBACK ******************************"
    run("ln -sf #{previous_release}/Gemfile #{shared_path}/Gemfile")
    run("cd #{previous_release} && bundle install")
  end
  task :symlink_vendor do
    p "********************** BUNDLER:SYMLINK ******************************"
    shared_gems = File.join(shared_path, 'vendor/bundler')
    release_gems = "#{release_path}/vendor/bundler"
    run("mkdir -p #{shared_gems} && ln -sfn #{shared_gems} #{release_gems}")
    run("ln -sf #{current_path}/Gemfile #{shared_path}/Gemfile")
  end

  task :run_gem_bundle do
    p "********************** BUNDLER:GEM BUNDLE ******************************"
    run("cd #{release_path} && bundle install")
  end

  task :new_release do
    bundler.symlink_vendor
    bundler.run_gem_bundle
  end
end
