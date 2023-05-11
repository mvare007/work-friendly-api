class FacilityAmenityCategoriesController < ApplicationController
  before_action :set_facility_amenity_category, only: %i[show update destroy]

  def index
    @facility_amenity_categories = FacilityAmenityCategory.order(:name)
    render json: { message: 'loaded facility_amenity_categories', data: @facility_amenity_categories }, status: :ok
  end

  def show
    render json: { message: 'loaded facility_amenity_category', data: @facility_amenity_category }, status: :ok
  end

  def create
    @facility_amenity_category = FacilityAmenityCategory.new(facility_amenity_category_params)
    if @facility_amenity_category.save
      render json: { message: 'facility_amenity_category is saved', data: @facility_amenity_category }, status: :ok
    else
      render json: { message: 'facility_amenity_category is not saved', data: @facility_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @facility_amenity_category.update(facility_amenity_category_params)
      render json: { message: 'facility_amenity_category is updated', data: @facility_amenity_category },
             status: :ok
    else
      render json: { message: 'facility_amenity_category is not updated', data: @facility_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @facility_amenity_category.destroy
      render json: { message: 'facility_amenity_category successfully deleted', data: @facility_amenity_category },
             status: :ok
    else
      render json: { message: 'facility_amenity_category is not deleted', data: @facility_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  private

  def facility_amenity_category_params
    params.permit(:name)
  end

  def set_facility_amenity_category
    @facility_amenity_category = FacilityAmenityCategory.find_by(id: params[:id])
    @facility_amenity_category.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                                         status: :unprocessable_entity
  end
end
