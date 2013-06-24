require 'test_helper'

class MemoryTimeManagerTest < ActiveSupport::TestCase
  test 'initialize with nil' do
    memory_time_manager = MemoryTimeManager.new(nil)
    assert_equal memory_time_manager.time_owner, nil
    assert_equal memory_time_manager.time_left, nil
    assert_equal memory_time_manager.time_locked, nil
  end

  test 'initialize with time owner' do
    memory_time_manager = MemoryTimeManager.new(time_owner)
    assert_equal memory_time_manager.time_owner, time_owner
    assert_equal memory_time_manager.time_left, 20
    assert_equal memory_time_manager.time_locked, 10
  end

  test 'add time with no errors' do
    memory_time_manager = MemoryTimeManager.new(time_owner)
    assert_equal memory_time_manager.add_time(20), 40
  end

  test 'lock time with no errors' do
    memory_time_manager = MemoryTimeManager.new(time_owner)
    memory_time_manager.lock_time(10)
    assert_equal memory_time_manager.time_locked, 20
    assert_equal memory_time_manager.time_left, 10
  end

  test 'remove time with no errors' do
    memory_time_manager = MemoryTimeManager.new(time_owner)
    memory_time_manager.remove_time(10)
    assert_equal memory_time_manager.time_locked, 0
    assert_equal memory_time_manager.time_left, 20
  end

  test 'unlock time with no errors' do
    memory_time_manager = MemoryTimeManager.new(time_owner)
    memory_time_manager.unlock_time(10)
    assert_equal memory_time_manager.time_locked, 0
    assert_equal memory_time_manager.time_left, 30
  end

  def time_owner(*args)
    options = args.extract_options!
    @user ||= OpenStruct.new(
        :name => options[:name] || 'Juan de Dios',
        :time_left => options[:time_left] || 20,
        :time_locked => options[:time_locked] || 10
    )
  end
end