# app/controllers/activities_controller.rb

class ActivitiesController < ApplicationController
  before_action :authenticate_visitor!
  before_action :set_activity, only: [:show]
  before_action :set_city, only: [:show]

  def index
    @activities = Activity.all
    @recommended_activities = Activity.joins(:activity_views).group('activities.id').order('COUNT(activity_views.id) DESC').limit(5)
  end

  def show
    @activity = Activity.find(params[:id])
    @activities = Activity.all 
    if visitor_signed_in?
      current_visitor.activity_views.create(activity: @activity)
    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_city
    @city = @activity.city
  end
end
