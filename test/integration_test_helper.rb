require 'test_helper'
require 'capybara/rails'

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
  end
end