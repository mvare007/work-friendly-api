class Api::V1::CountriesController < ApplicationController
  before_action :set_country, only: %i[show update destroy]

  def index
    @countries = Country.order(:name)
    return unless stale?(@countries)

    render json: CountryBlueprint.render(@countries, root: :countries), status: :ok
  end

  def show
    render json: CountryBlueprint.render(@country), status: :ok
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      render json: CountryBlueprint.render(@country), status: :ok
    else
      render json: { country: CountryBlueprint.render(@country), errors: @country.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @country.update(country_params)
      render json: CountryBlueprint.render(@country), status: :ok
    else
      render json: { country: CountryBlueprint.render(@country), errors: @country.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @country.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { country: CountryBlueprint.render(@country), errors: @country.errors },
             status: :unprocessable_entity
    end
  end

  private

  def country_params
    params.permit(:dialing_code, :currency, :iso_code, :name)
  end

  def set_country
    @country = Country.find_by(id: params[:id])
    @country.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                       status: :unprocessable_entity
  end
end
