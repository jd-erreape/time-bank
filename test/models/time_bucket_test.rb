require 'test_helper'

class TimeBucketTest < ActiveSupport::TestCase
  test 'initialize with nil' do
    time_bucket = TimeBucket.new(nil)
    assert_equal time_bucket.time_left, nil
    assert_equal time_bucket.time_locked, nil
  end

  test 'initialize with time params' do
    time_bucket = TimeBucket.new(time_params)
    assert_equal time_bucket.time_left, 20
    assert_equal time_bucket.time_locked, 10
  end

  test 'add time' do
    time_bucket = TimeBucket.new(time_params)
    assert_equal time_bucket.add_time(20), true
    assert_equal time_bucket.time_left, 40
  end

  test 'lock time with no errors' do
    time_bucket = TimeBucket.new(time_params)
    assert_equal time_bucket.lock_time(10), true
    assert_equal time_bucket.time_locked, 20
    assert_equal time_bucket.time_left, 10
  end

  test 'lock time with errors' do
    time_bucket = TimeBucket.new(:time_left => 5, :time_locked => 0)
    assert_equal time_bucket.lock_time(10), false
  end

  test 'remove time with no errors' do
    time_bucket = TimeBucket.new(time_params)
    assert_equal time_bucket.remove_time(10), true
    assert_equal time_bucket.time_locked, 0
    assert_equal time_bucket.time_left, 20
  end

  test 'remove time with errors' do
    time_bucket = TimeBucket.new(:time_left => 5, :time_locked => 0)
    assert_equal time_bucket.remove_time(10), false
  end

  test 'unlock time' do
    time_bucket = TimeBucket.new(time_params)
    time_bucket.unlock_time(10)
    assert_equal time_bucket.time_locked, 0
    assert_equal time_bucket.time_left, 30
  end

  test 'stale objects' do
    time_bucket = TimeBucket.create(time_params)
    stale_time_bucket = TimeBucket.find(time_bucket.id)
    time_bucket.add_time(10)
    stale_time_bucket.add_time(10)
    assert_equal stale_time_bucket.valid?, false
    assert stale_time_bucket.errors.full_messages.include?('The record was stale in save operation')
  end

  def time_params(*args)
    options = args.extract_options!
    {
        :time_left => options[:time_left] || 20,
        :time_locked => options[:time_locked] || 10
    }
  end
end