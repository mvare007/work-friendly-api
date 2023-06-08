class Api::V1::CitiesController < ApplicationController
  before_action :set_city, only: %i[show update destroy]

  # @route GET /api/v1/cities(/page/:page/per_page/:per_page) {format: :json} (api_v1_cities)
  # @route GET /api/v1/cities {format: :json}
  def index
    @cities = City.order(:name)
    return unless stale?(@cities)

    render json: CityBlueprint.render(@cities, root: :cities), status: :ok
  end

  # @route GET /api/v1/cities/:id {format: :json} (api_v1_city)
  def show
    render json: CityBlueprint.render(@city), status: :ok
  end

  # @route POST /api/v1/cities {format: :json}
  def create
    @city = City.new(city_params)

    if @city.save
      render json: CityBlueprint.render(@city), status: :ok
    else
      render json: { city: CityBlueprint.render(@city), errors: @city.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/cities/:id {format: :json} (api_v1_city)
  # @route PUT /api/v1/cities/:id {format: :json} (api_v1_city)
  def update
    if @city.update(city_params)
      render json: CityBlueprint.render(@city), status: :ok
    else
      render json: { city: CityBlueprint.render(@city), errors: @city.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/cities/:id {format: :json} (api_v1_city)
  def destroy
    if @city.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { city: CityBlueprint.render(@city), errors: @city.errors },
             status: :unprocessable_entity
    end
  end

  private

  def city_params
    params.permit(:name, :country_id)
  end

  def set_city
    @city = City.find_by(id: params[:id])
    @city.present? or return render json: { errors: t('errors.messages.item_not_found') }, status: :unprocessable_entity
  end
end
