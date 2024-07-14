class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show]
  before_action :set_city, only: [:show]

  def show
    @activities = Activity.where(city_id: @city.id)
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_city
    @city = @activity.city
  end
end
