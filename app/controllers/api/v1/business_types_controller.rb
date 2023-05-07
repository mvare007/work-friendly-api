class Api::V1::BusinessTypesController < ApplicationController
  before_action :set_business_type, only: %i[show update destroy]

  def index
    @business_types = BusinessType.order(:name)
                                  .page(params[:page])
                                  .per(params[:per_page])
    return unless stale?(@business_types)

    render json: { message: 'loaded business_type', data: @business_types }, status: :ok
  end

  def show
    render json: { message: 'loaded business_type', data: @business_types }, status: :ok
  end

  def create
    @business_type = BusinessType.new(business_type_params)

    if @business_type.save
      render json: { message: 'business_type is saved', data: @business_type }, status: :ok
    else
      render json: { message: 'business_type is not saved', data: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @business_type.update(business_type_params)
      render json: { message: 'business_type is updated', data: @business_type }, status: :ok
    else
      render json: { message: 'business_type is not updated', data: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @business_type.destroy
      render json: { message: 'business_type successfully deleted', data: @business_type }, status: :ok
    else
      render json: { message: 'business_type is not deleted', data: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  private

  def business_type_params
    params.permit(:name)
  end

  def set_business_type
    @business_type = BusinessType.find_by(id: params[:id])
    @business_type.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                             status: :unprocessable_entity
  end
end
