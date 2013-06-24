class MemoryTimeManager
  attr_reader :time_owner, :time_left, :time_locked

  def initialize(time_owner)
    @time_owner = time_owner
    @time_left = time_owner.try(:time_left)
    @time_locked = time_owner.try(:time_locked)
  end

  def add_time(time_to_add)
    @time_left += time_to_add
  end

  def lock_time(time_to_lock)
    @time_left -= time_to_lock
    @time_locked += time_to_lock
  end

  def unlock_time(time_to_unlock)
    @time_left += time_to_unlock
    @time_locked -= time_to_unlock
  end

  def remove_time(time_to_remove)
    @time_locked -= time_to_remove
  end
end