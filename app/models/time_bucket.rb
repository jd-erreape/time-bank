# This class has optimistic locking, if the record is staled when performing the operation, it won't be valid and
# will include the properly error message as a normal ActiveRecord validation message

# A example of a implementation without ActiveRecord cand be found in:
# https://gist.github.com/jd-erreape/63c0bb90cf89f2571a8c
class TimeBucket < ActiveRecord::Base
  include ActiveSupport::Rescuable

  rescue_from ActiveRecord::StaleObjectError, :with => :stale_object_handler

  belongs_to :user

  validates :time_left, :time_locked, numericality: {greater_than_or_equal_to: 0}
  validate :time_bucket_is_not_stale

  def add_time(time_to_add)
    execute { update_attributes(:time_left => time_left + time_to_add) }
  end

  def lock_time(time_to_lock)
    execute { update_attributes(:time_left => time_left - time_to_lock, :time_locked => time_locked + time_to_lock) }
  end

  def unlock_time(time_to_unlock)
    execute { update_attributes(:time_left => time_left + time_to_unlock, :time_locked => time_locked - time_to_unlock) }
  end

  def remove_time(time_to_remove)
    execute { update_attributes(:time_locked => time_locked - time_to_remove) }
  end

  private

  def execute(&block)
    yield
  rescue Exception => exception
    rescue_with_handler(exception) || raise
  end

  def stale_object_handler
    @stale_object = true
  end

  def time_bucket_is_not_stale
    errors.add(:base, 'The record was stale in save operation') if @stale_object
  end
end
