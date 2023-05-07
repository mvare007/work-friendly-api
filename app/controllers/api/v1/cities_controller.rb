class Api::V1::CitiesController < ApplicationController
  before_action :set_city, only: %i[show update destroy]

  def index
    @cities = City.order(:name)
    render json: { message: 'loaded cities', data: @Cities }, status: :ok
  end

  def show
    render json: { message: 'loaded city', data: @city }, status: :ok
  end

  def create
    @city = City.new(city_params)

    if @city.save
      render json: { message: 'city is saved', data: @city }, status: :ok
    else
      render json: { message: 'city is not saved', data: @city.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @city.update(city_params)
      render json: { message: 'city is updated', data: @city }, status: :ok
    else
      render json: { message: 'city is not updated', data: @city.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @city.destroy
      render json: { message: 'city successfully deleted', data: @city }, status: :ok
    else
      render json: { message: 'city is not deleted', data: @city.errors },
             status: :unprocessable_entity
    end
  end

  private

  def city_params
    params.permit(:name, :active, :country_id)
  end

  def set_city
    @city = City.find_by(id: params[:id])
    @city.present? or return render json: { errors: t('errors.messages.item_not_found') }, status: :unprocessable_entity
  end
end
