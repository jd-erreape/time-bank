# This class has optimistic locking and it's raising all its exceptions. If you're going
# to use this class, make sure that you're handling ActiveRecord::StaleObjectError properly as you can see
# in https://blog.engineyard.com/2011/a-guide-to-optimistic-locking

# A example of a implementation without ActiveRecord cand be found in:
# https://gist.github.com/jd-erreape/63c0bb90cf89f2571a8c
class TimeBucket < ActiveRecord::Base
  belongs_to :user

  validates :time_left, :time_locked, numericality: {greater_than_or_equal_to: 0}

  def add_time(time_to_add)
    update_attributes(:time_left => time_left + time_to_add)
  end

  def lock_time(time_to_lock)
    update_attributes(:time_left => time_left - time_to_lock, :time_locked => time_locked + time_to_lock)
  end

  def unlock_time(time_to_unlock)
    update_attributes(:time_left => time_left + time_to_unlock, :time_locked => time_locked - time_to_unlock)
  end

  def remove_time(time_to_remove)
    update_attributes(:time_locked => time_locked - time_to_remove)
  end
end
