# app/controllers/activities_controller.rb
require 'pycall/import'
include PyCall::Import

class ActivitiesController < ApplicationController
  before_action :authenticate_visitor!
  before_action :set_activity, only: [:show]
  before_action :set_city, only: [:show]

  def index
    @activities = Activity.all
    @recommended_activities = recommend_activities(current_visitor.id)
  end

  def show
    @activities = Activity.all 
    if visitor_signed_in?
      current_visitor.activity_views.create(
        activity: @activity,
        title: @activity.title,
        price: @activity.price,
        rating: @activity.rating,
        place: @activity.place,
        theme: @activity.theme,
        duration: @activity.duration
      )
    end
    @recommended_activities = recommend_activities(current_visitor.id)
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_city
    @city = @activity.city
  end

  def recommend_activities(visitor_id)
    pyimport :sys
    pyimport :os

    # Set the correct path
    os.chdir('/myapp/lib/python')
    sys.path.append('/myapp/lib/python')

    # Import the recommend module
    pyimport :recommend

    sys.argv = ['recommend.py', visitor_id.to_s]
    recommendations = recommend.main()

    activity_ids = recommendations.to_a
    Activity.where(id: activity_ids)
  end
end
