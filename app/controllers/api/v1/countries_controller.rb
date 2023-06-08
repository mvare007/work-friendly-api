class Api::V1::CountriesController < ApplicationController
  before_action :set_country, only: %i[show update destroy]

  # @route GET /api/v1/countries(/page/:page/per_page/:per_page) {format: :json} (api_v1_countries)
  # @route GET /api/v1/countries {format: :json}
  def index
    @countries = Country.order(:name)
    return unless stale?(@countries)

    render json: CountryBlueprint.render(@countries, root: :countries), status: :ok
  end

  # @route GET /api/v1/countries/:id {format: :json} (api_v1_country)
  def show
    render json: CountryBlueprint.render(@country), status: :ok
  end

  # @route POST /api/v1/countries {format: :json}
  def create
    @country = Country.new(country_params)

    if @country.save
      render json: CountryBlueprint.render(@country), status: :ok
    else
      render json: { country: CountryBlueprint.render(@country), errors: @country.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/countries/:id {format: :json} (api_v1_country)
  # @route PUT /api/v1/countries/:id {format: :json} (api_v1_country)
  def update
    if @country.update(country_params)
      render json: CountryBlueprint.render(@country), status: :ok
    else
      render json: { country: CountryBlueprint.render(@country), errors: @country.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/countries/:id {format: :json} (api_v1_country)
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
