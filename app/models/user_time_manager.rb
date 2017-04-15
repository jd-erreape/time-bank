require 'active_model'

class UserTimeManager
  include ActiveModel::Validations

  DEFAULT_TIME_FIELD_NAME = 'time_left'

  validates :time_left, :numericality => {:greater_than_or_equal_to => 0}

  attr_accessor :time_left

  def initialize(user, time_field_name=DEFAULT_TIME_FIELD_NAME)
    @user = user
    @time_field_name = time_field_name
    @time_left = user.send(@time_field_name) || 0
  end

  def increase_time(time_increase)
    @time_left += time_increase
    self.valid?
  end

  def decrease_time(time_decrease)
    @time_left -= time_decrease
    self.valid?
  end

  #TODO test and uncomment when Mocha merged
  def update_user_time_left
    #if self.valid?
      #user.send("#{@time_field_name}=",@time_left)
      #user.save
    #else
    #  false
    #end
  end
end