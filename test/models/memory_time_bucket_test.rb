require 'test_helper'

class MemoryTimeBucketTest < ActiveSupport::TestCase
  test 'initialize with nil' do
    memory_time_manager = MemoryTimeBucket.new(nil)
    assert_equal memory_time_manager.time_left, nil
    assert_equal memory_time_manager.time_locked, nil
  end

  test 'initialize with time params' do
    memory_time_manager = MemoryTimeBucket.new(time_params)
    assert_equal memory_time_manager.time_left, 20
    assert_equal memory_time_manager.time_locked, 10
  end

  test 'add time errors' do
    memory_time_manager = MemoryTimeBucket.new(time_params)
    assert_equal memory_time_manager.add_time(20), true
    assert_equal memory_time_manager.time_left, 40
  end

  test 'lock time with no errors' do
    memory_time_manager = MemoryTimeBucket.new(time_params)
    assert_equal memory_time_manager.lock_time(10), true
    assert_equal memory_time_manager.time_locked, 20
    assert_equal memory_time_manager.time_left, 10
  end

  test 'lock time with errors' do
    memory_time_manager = MemoryTimeBucket.new(:time_left => 5, :time_locked => 0)
    assert_equal memory_time_manager.lock_time(10), false
  end

  test 'remove time with no errors' do
    memory_time_manager = MemoryTimeBucket.new(time_params)
    assert_equal memory_time_manager.remove_time(10), true
    assert_equal memory_time_manager.time_locked, 0
    assert_equal memory_time_manager.time_left, 20
  end

  test 'remove time with errors' do
    memory_time_manager = MemoryTimeBucket.new(:time_left => 5, :time_locked => 0)
    assert_equal memory_time_manager.remove_time(10), false
  end

  test 'unlock time errors' do
    memory_time_manager = MemoryTimeBucket.new(time_params)
    memory_time_manager.unlock_time(10)
    assert_equal memory_time_manager.time_locked, 0
    assert_equal memory_time_manager.time_left, 30
  end

  def time_params(*args)
    options = args.extract_options!
    {
        :time_left => options[:time_left] || 20,
        :time_locked => options[:time_locked] || 10
    }
  end
end