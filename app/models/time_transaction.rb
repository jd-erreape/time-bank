class TimeTransaction
  attr_accessor :giver, :receiver, :item
  attr_reader :status

  NEW = 0
  STARTED = 1
  ACCEPTED = 2
  REJECTED = 3

  def initialize(*args)
    options = args.extract_options!
    @giver = options[:giver]
    @receiver = options[:receiver]
    @item = options[:item]
  end

  def start
    @status = STARTED if perform_time_locking!
  end

  def accept
    @status = ACCEPTED if perform_time_exchange!
  end

  def reject
    @status = REJECTED if can_be_rejected?
  end

  def status
    @status ||= load_time_transaction_status
  end

  private

  def perform_time_locking!
    status == NEW && @receiver.lock_time(@item.time)
  end

  def perform_time_exchange!
    # TODO This should be surrounded by an ActiveRecord transaction (must be atomic)
    # Maybe the remove_time method should unlock the time already locked when the transaction was STARTED
    status == STARTED && @receiver.remove_time(@item.time) && @giver.add_time(@item.time)
  end

  def can_be_rejected?
    status != ACCEPTED
  end

  def load_time_transaction_status
    NEW
  end
end