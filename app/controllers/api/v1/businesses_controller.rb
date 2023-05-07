class Api::V1::BusinessesController < ApplicationController
  before_action :set_business, only: %i[show update destroy]

  def index
    @businesses = Business.order(:name)
                          .page(params[:page])
                          .per(params[:per_page])
    return unless stale?(@businesses)

    render json: { message: 'loaded businesses', data: @businesses }, status: :ok
  end

  def show
    render json: { message: 'loaded business', data: @business }, status: :ok
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      render json: { message: 'business is saved', data: @business }, status: :ok
    else
      render json: { message: 'business is not saved', data: @business.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @business.update(business_params)
      render json: { message: 'business is updated', data: @business }, status: :ok
    else
      render json: { message: 'business is not updated', data: @business.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @business.destroy
      render json: { message: 'business successfully deleted', data: @business }, status: :ok
    else
      render json: { message: 'business is not deleted', data: @business.errors },
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
      :city_id
    )
  end

  def set_business
    @business = Business.find_by(id: params[:id])
    @business.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                        status: :unprocessable_entity
  end
end
