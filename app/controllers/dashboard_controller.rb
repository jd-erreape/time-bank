class DashboardController < ApplicationController
  def show
    @favor = Favor.new
  end
end