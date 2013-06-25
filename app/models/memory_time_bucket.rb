require 'active_model'

class MemoryTimeBucket
  include ActiveModel::Validations

  validates :time_left, :time_locked, numericality: {greater_than_or_equal_to: 0}

  attr_accessor :time_left, :time_locked
  
  def initialize(*args)
    options = args.extract_options!
    @time_left = options[:time_left]
    @time_locked = options[:time_locked]
  end

  def add_time(time_to_add)
    @time_left += time_to_add
    self.valid?
  end

  def lock_time(time_to_lock)
    @time_left -= time_to_lock
    @time_locked += time_to_lock
    self.valid?
  end

  def unlock_time(time_to_unlock)
    @time_left += time_to_unlock
    @time_locked -= time_to_unlock
    self.valid?
  end

  def remove_time(time_to_remove)
    @time_locked -= time_to_remove
    self.valid?
  end
end