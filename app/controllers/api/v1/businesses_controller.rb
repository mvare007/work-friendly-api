class Api::V1::BusinessesController < ApplicationController
  before_action :set_business, only: %i[show update destroy]

  def index
    @businesses = Business.includes(:schedule_days, :social_links)
                          .order(:name)
                          .page(params[:page])
                          .per(params[:per_page])
    return unless stale?(@businesses)

    render json: BusinessBlueprint.render(@businesses, root: :businesses), status: :ok
  end

  def show
    render json: BusinessBlueprint.render(@business, view: :extended), status: :ok
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      render json: BusinessBlueprint.render(@business), status: :ok
    else
      render json: { business: BusinessBlueprint.render(@business), errors: @business.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @business.update(business_params)
      render json: BusinessBlueprint.render(@business), status: :ok
    else
      render json: { business: BusinessBlueprint.render(@business), errors: @business.errors },
             status: :unprocessable_entity
    end
  end

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
