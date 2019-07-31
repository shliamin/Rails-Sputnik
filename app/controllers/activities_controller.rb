class ActivitiesController < ApplicationController
before_action :set_city

  def show
    @activity = Activity.find(params[:id])
  end

  private
  def set_city
    @city = City.find(params[:city_id])
  end
end
