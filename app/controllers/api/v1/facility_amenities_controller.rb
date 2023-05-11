class FacilityAmenitesController < ApplicationController
  before_action :set_facility_amenity, only: %i[show update destroy]

  def index
    @facility_amenities = FacilityAmenity.order(:name)
                                         .page(params[:page])
                                         .per(params[:per_page])
    render json: { message: 'loaded facility_amenities', data: @facility_amenities }, status: :ok
  end

  def show
    render json: { message: 'loaded facility_amenity', data: @facility_amenity }, status: :ok
  end

  def create
    @facility_amenity = FacilityAmenity.new(facility_amenity_params)
    if @facility_amenity.save
      render json: { message: 'facility_amenity is saved', data: @facility_amenity }, status: :ok
    else
      render json: { message: 'facility_amenity is not saved', data: @facility_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @facility_amenity.update(facility_amenity_params)
      render json: { message: 'facility_amenity is updated', data: @facility_amenity },
             status: :ok
    else
      render json: { message: 'facility_amenity is not updated', data: @facility_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @facility_amenity.destroy
      render json: { message: 'facility_amenity successfully deleted', data: @facility_amenity },
             status: :ok
    else
      render json: { message: 'facility_amenity is not deleted', data: @facility_amenity.errors },
             status: :unprocessable_entity
    end
  end

  private

  def facility_amenity_params
    params.permit(:name, :description, :facility_amenity_category_id)
  end

  def set_facility_amenity
    @facility_amenity = FacilityAmenity.find_by(id: params[:id])
    @facility_amenity.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                                status: :unprocessable_entity
  end
end
