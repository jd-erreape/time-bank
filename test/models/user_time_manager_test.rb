require 'test_helper'

class UserTimeManagerTest < ActiveSupport::TestCase

  #TODO remplaze with fixture after devise branch is merged
  class User
    attr_accessor :time_left
    attr_accessor :alternative_time_left
  end

  test 'initialization without time' do
    user = User.new
    assert_equal UserTimeManager.new(user).time_left, 0
  end

  test 'initialization with time' do
    user = User.new
    user.time_left = 1200
    assert_equal UserTimeManager.new(user).time_left, 1200
  end

  test 'initialization with a different field name' do
    user = User.new
    user.alternative_time_left = 2400
    assert_equal UserTimeManager.new(user, 'alternative_time_left').time_left, 2400
  end

  test 'is valid if time_left is equal to 0' do
    user = User.new
    user.time_left = 0
    assert UserTimeManager.new(user).valid?
  end

  test 'is valid if time_left is greater than 0' do
    user = User.new
    user.time_left = 100
    assert UserTimeManager.new(user).valid?
  end

  test 'is not valid if time_left is not greater than or equal to 0' do
    user = User.new
    user.time_left = -1
    assert_not UserTimeManager.new(user).valid?
  end

  test 'increase time_left' do
    user = User.new
    user.time_left = 1000
    assert UserTimeManager.new(user).increase_time(10), 1010
  end

  test 'decrease time_left' do
    user = User.new
    user.time_left = 1000
    assert UserTimeManager.new(user).decrease_time(10), 990
  end

  test 'increase time_left must return if the object is valid' do
    user = User.new
    user.time_left = 1000
    assert UserTimeManager.new(user).increase_time(10)
    user.time_left = -100
    assert_not UserTimeManager.new(user).increase_time(10)
  end

  test 'decrease time_left must return if the object is valid' do
    user = User.new
    user.time_left = 1000
    assert UserTimeManager.new(user).decrease_time(10)
    user.time_left = -100
    assert_not UserTimeManager.new(user).decrease_time(10)
  end

  test 'update user time left' do
    skip 'TODO when merged mocha or devise (better avoid database so wait for mocha)'
  end
end