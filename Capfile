require 'rvm/capistrano'
load 'deploy'
set :rvm_ruby_string, 'ruby-2.0.0-p195@time-bank' # Defaults to 'default
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
load 'config/deploy' # remove this line to skip loading any of the default tasks
load 'deploy/assets' if variables[:stage] == "production"
