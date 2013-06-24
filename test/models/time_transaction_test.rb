require 'test_helper'
require 'mocha/setup'

class TimeTransactionTest < ActiveSupport::TestCase
  setup do
    @giver = Giver.new
    @receiver = Receiver.new
    @item = Item.new
    @time_transaction = TimeTransaction.new(giver: @giver, receiver: @receiver, item: @item)
  end

  test 'initialize with giver, receiver and item' do
    assert_equal @time_transaction.giver, @giver
    assert_equal @time_transaction.receiver, @receiver
    assert_equal @time_transaction.item, @item
  end

  test 'initialize time transaction with status' do
    assert_equal TimeTransaction.new.status, TimeTransaction::NEW
  end

  test 'start transaction if new' do
    @time_transaction.item.time = 60
    @receiver.expects(:lock_time).with(@item.time).returns(true)
    @time_transaction.start
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'start transaction if it is not new' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @receiver.expects(:lock_time).never
    @time_transaction.start
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'start transaction if it fails to lock time' do
    @receiver.expects(:lock_time).returns(false)
    @time_transaction.start
    assert_equal TimeTransaction::NEW, @time_transaction.status
  end

  test 'reject transaction' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::NEW)
    @receiver.expects(:unlock_time).with(@item.time).returns(true)
    @time_transaction.reject
    assert_equal TimeTransaction::REJECTED, @time_transaction.status
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @receiver.expects(:unlock_time).with(@item.time).returns(true)
    @time_transaction.reject
    assert_equal TimeTransaction::REJECTED, @time_transaction.status
  end

  test 'accept transaction it everything goes well' do
    @time_transaction.item.time = 60
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @receiver.expects(:remove_time).with(@item.time).returns(true)
    @giver.expects(:add_time).with(@item.time).returns(true)
    @time_transaction.accept
    assert_equal TimeTransaction::ACCEPTED, @time_transaction.status
  end

  test 'accept transaction it remove time goes wrong' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @receiver.expects(:remove_time).returns(false)
    @giver.expects(:add_time).never
    @time_transaction.accept
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'accept transaction it add time goes wrong' do
    @time_transaction.instance_variable_set('@status', TimeTransaction::STARTED)
    @receiver.expects(:remove_time).returns(true)
    @giver.expects(:add_time).returns(false)
    @time_transaction.accept
    assert_equal TimeTransaction::STARTED, @time_transaction.status
  end

  test 'accept transaction it is not started' do
    @receiver.expects(:remove_time).never
    @giver.expects(:add_time).never
    @time_transaction.accept
    assert_equal TimeTransaction::NEW, @time_transaction.status
  end

  class Giver
  end

  class Receiver
  end

  class Item
    attr_accessor :time
  end
end
