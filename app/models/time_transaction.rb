class TimeTransaction
  attr_accessor :time_giver, :time_receiver, :time
  attr_reader :status

  NEW = 0
  STARTED = 1
  ACCEPTED = 2
  REJECTED = 3

  # Public: constructor
  #
  # time_giver - is giving a time so will gain its time
  # time_receiver - is receiving a time so will lose its time
  def initialize(*args)
    options = args.extract_options!
    @time_receiver = options[:time_receiver]
    @time_giver = options[:time_giver]
    @time = options[:time]
  end

  def start
    @status = STARTED if perform_time_locking!
  end

  def accept
    @status = ACCEPTED if perform_time_exchange!
  end

  def reject
    @status = REJECTED if perform_rejection!
  end

  def status
    @status ||= load_time_transaction_status
  end

  private

  def perform_time_locking!
    status == NEW && @time_giver.lock_time(@time)
  end

  def perform_time_exchange!
    # TODO This should be surrounded by an ActiveRecord transaction (must be atomic)
    status == STARTED && @time_giver.remove_time(@time) && @time_receiver.add_time(@time)
  end

  def perform_rejection!
    status != ACCEPTED && @time_giver.unlock_time(@time)
  end

  def load_time_transaction_status
    NEW
  end
end