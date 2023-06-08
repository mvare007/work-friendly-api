class Api::V1::FacilityAmenitiesController < ApplicationController
  before_action :set_facility_amenity, only: %i[show update destroy]

  def index
    @facility_amenities = FacilityAmenity.order(:name)
                                         .page(params[:page])
                                         .per(params[:per_page])

    render json: FacilityAmenityBlueprint.render(@facility_amenities, root: :facility_amenities), status: :ok
  end

  def show
    render json: FacilityAmenityBlueprint.render(@facility_amenity), status: :ok
  end

  def create
    @facility_amenity = FacilityAmenity.new(facility_amenity_params)
    if @facility_amenity.save
      render json: facility_amenityBlueprint.render(@facility_amenity), status: :ok
    else
      render json: { facility_amenity: FacilityAmenityBlueprint.render(@facility_amenity), errors: @facility_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @facility_amenity.update(facility_amenity_params)
      render json: facility_amenityBlueprint.render(@facility_amenity), status: :ok
    else
      render json: { facility_amenity: FacilityAmenityBlueprint.render(@facility_amenity), errors: @facility_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @facility_amenity.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { facility_amenity: FacilityAmenityBlueprint.render(@facility_amenity), errors: @facility_amenity.errors },
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
