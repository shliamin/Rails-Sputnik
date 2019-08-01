class ActivitiesController < ApplicationController


  def show
    @activity = Activity.find(params[:id])
    @activities = Activity.all
  end

  private
  def set_city
    @city = City.find(params[:city_id])
  end
end
