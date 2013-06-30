require 'test_helper'
require 'mocha/setup'

class TimeTransactionTest < ActiveSupport::TestCase
  setup do
    @time_giver = TimeGiver.new
    @time_receiver = TimeReceiver.new
    @time = rand()
    @time_transaction = TimeTransaction.new(time_giver: @time_giver, time_receiver: @time_receiver, time: @time)
  end

  test 'initialize with time_giver, time_receiver and time' do
    assert_equal @time_transaction.time_giver, @time_giver
    assert_equal @time_transaction.time_receiver, @time_receiver
    assert_equal @time_transaction.time, @time
  end

  test 'initialize time transaction with status' do
    assert_equal TimeTransaction.new.status, TimeTransaction::NEW
  end

  test 'start transaction if new' do
    @time_giver.expects(:lock_time).with(@time).returns(true)
    @time_transaction.start
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'start transaction if it is not new' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @time_giver.expects(:lock_time).never
    @time_transaction.start
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'start transaction if it fails to lock time' do
    @time_giver.expects(:lock_time).returns(false)
    @time_transaction.start
    assert_equal TimeTransaction::NEW, @time_transaction.status
  end

  test 'reject transaction if it is new' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::NEW)
    @time_giver.expects(:unlock_time).never
    @time_transaction.reject
    assert_equal TimeTransaction::REJECTED, @time_transaction.status
  end

  test 'reject transaction if it is accepted' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @time_giver.expects(:unlock_time).with(@time).returns(true)
    @time_transaction.reject
    assert_equal TimeTransaction::REJECTED, @time_transaction.status
  end

  test 'accept transaction if everything goes well' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @time_giver.expects(:remove_time).with(@time).returns(true)
    @time_receiver.expects(:add_time).with(@time).returns(true)
    @time_transaction.accept
    assert_equal TimeTransaction::ACCEPTED, @time_transaction.status
  end

  test 'accept transaction if remove time goes wrong' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @time_giver.expects(:remove_time).returns(false)
    @time_receiver.expects(:add_time).never
    @time_transaction.accept
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'accept transaction it add time goes wrong' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @time_giver.expects(:remove_time).returns(true)
    @time_receiver.expects(:add_time).returns(false)
    @time_transaction.accept
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'accept transaction it is not started' do
    @time_giver.expects(:remove_time).never
    @time_receiver.expects(:add_time).never
    @time_transaction.accept
    assert_equal TimeTransaction::NEW, @time_transaction.status
  end

  class TimeGiver
  end

  class TimeReceiver
  end
end
