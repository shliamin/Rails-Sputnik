class CitiesController < ApplicationController
  before_action :authenticate_visitor!, except: [:index]
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  def index
    # All cities here:
    @cities = City.all
    # All activities here:
    @activities = Activity.all
  end

  # GET /cities/1
  def show
    @activities = @city.activities
    calculate_city_views
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to @city, notice: 'City was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      redirect_to @city, notice: 'City was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
    redirect_to cities_url, notice: 'City was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Calculate total views for the city
  def calculate_city_views
    @city.update(view_id: @city.activities.sum(:view_id))
  end

  # Only allow a trusted parameter "white list" through.
  def city_params
    params.require(:city).permit(:name, :photo, :description)
  end
end
