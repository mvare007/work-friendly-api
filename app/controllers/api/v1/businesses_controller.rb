class Api::V1::BusinessesController < ApplicationController
  before_action :set_business, only: %i[show update destroy]

  # @route GET /api/v1/businesses(/page/:page/per_page/:per_page) {format: :json} (api_v1_businesses)
  # @route GET /api/v1/businesses {format: :json}
  def index
    @businesses = Business.includes(:schedule_days, :social_links)
                          .order(:name)
                          .page(params[:page])
                          .per(params[:per_page])
    return unless stale?(@businesses)

    render json: BusinessBlueprint.render(@businesses, root: :businesses), status: :ok
  end

  # @route GET /api/v1/businesses/:id {format: :json} (api_v1_business)
  def show
    render json: BusinessBlueprint.render(@business, view: :extended), status: :ok
  end

  # @route POST /api/v1/businesses {format: :json}
  def create
    @business = Business.new(business_params)

    if @business.save
      render json: BusinessBlueprint.render(@business), status: :ok
    else
      render json: { business: BusinessBlueprint.render(@business), errors: @business.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/businesses/:id {format: :json} (api_v1_business)
  # @route PUT /api/v1/businesses/:id {format: :json} (api_v1_business)
  def update
    if @business.update(business_params)
      render json: BusinessBlueprint.render(@business), status: :ok
    else
      render json: { business: BusinessBlueprint.render(@business), errors: @business.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/businesses/:id {format: :json} (api_v1_business)
  def destroy
    if @business.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { business: BusinessBlueprint.render(@business), errors: @business.errors },
             status: :unprocessable_entity
    end
  end

  private

  def business_params
    params.permit(
      :address,
      :capacity,
      :email,
      :latitude,
      :longitude,
      :name,
      :phone_number,
      :vat_number,
      :zip_code,
      :business_type_id,
      :city_id,
      social_links_attributes: %i[id platform url _destroy],
      schedule_days_attributes: %i[
        id
        holiday
        holiday_name
        weekday
        open_time
        close_time
        _destroy
      ]
    )
  end

  def set_business
    @business = Business.find_by(id: params[:id])
    @business.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                        status: :unprocessable_entity
  end
end
