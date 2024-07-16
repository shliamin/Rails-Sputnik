# app/controllers/activities_controller.rb
require 'pycall/import'
include PyCall::Import

class ActivitiesController < ApplicationController
  before_action :authenticate_visitor!
  before_action :set_activity, only: [:show, :update]
  before_action :set_city, only: [:show]

  def index
    @activities = Activity.all
    @recommended_activities = recommend_activities(current_visitor.id)
  end

  def show
    @activities = Activity.all 
    if visitor_signed_in?
      @activity_view = current_visitor.activity_views.find_or_create_by(activity: @activity)
    end
    @recommended_activities = recommend_activities(current_visitor.id)
  end

  def update
    if visitor_signed_in? && params[:user_rating]
      activity_view = current_visitor.activity_views.find_by(activity: @activity)
      if activity_view
        activity_view.update(user_rating: params[:user_rating])
      else
        current_visitor.activity_views.create(
          activity: @activity,
          title: @activity.title,
          price: @activity.price,
          rating: @activity.rating,
          place: @activity.place,
          theme: @activity.theme,
          duration: @activity.duration,
          user_rating: params[:user_rating]
        )
      end
    end
    redirect_to activity_path(@activity)
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

    begin
      # Set the correct path
      os.chdir('/myapp/lib/python')
      sys.path.append('/myapp/lib/python')

      # Import the recommend module
      pyimport :recommend

      sys.argv = ['recommend.py', visitor_id.to_s]
      recommendations = recommend.main()

      activity_ids = recommendations.to_a
      Activity.where(id: activity_ids)
    rescue => e
      logger.error "Error recommending activities: #{e.message}"
      []
    end
  end
end
