require 'coveralls'
Coveralls.wear!('rails')

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)

# This is added because of a bug in rails4 with zeus that makes test runs twice
#require 'minitest/unit'
#MiniTest::Unit.class_variable_set('@@installed_at_exit', true)

require 'rails/test_help'
require 'redgreen'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
