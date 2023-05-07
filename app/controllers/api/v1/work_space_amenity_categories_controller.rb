class WorkSpaceAmenityCategoriesController < ApplicationController
  before_action :set_work_space_amenity_category, only: %i[show update destroy]

  def index
    @work_space_amenity_categories = WorkSpaceAmenityCategory.order(:name)
    render json: { message: 'loaded work_space_amenity_categories', data: @work_space_amenity_categories }, status: :ok
  end

  def show
    render json: { message: 'loaded work_space_amenity_category', data: @work_space_amenity_category }, status: :ok
  end

  def create
    @work_space_amenity_category = WorkSpaceAmenityCategory.new(work_space_amenity_category_params)
    if @work_space_amenity_category.save
      render json: { message: 'work_space_amenity_category is saved', data: @work_space_amenity_category }, status: :ok
    else
      render json: { message: 'work_space_amenity_category is not saved', data: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @work_space_amenity_category.update(work_space_amenity_category_params)
      render json: { message: 'work_space_amenity_category is updated', data: @work_space_amenity_category },
             status: :ok
    else
      render json: { message: 'work_space_amenity_category is not updated', data: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @work_space_amenity_category.destroy
      render json: { message: 'work_space_amenity_category successfully deleted', data: @work_space_amenity_category },
             status: :ok
    else
      render json: { message: 'work_space_amenity_category is not deleted', data: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  private

  def work_space_amenity_category_params
    params.permit(:name)
  end

  def set_work_space_amenity_category
    @work_space_amenity_category = WorkSpaceAmenityCategory.find_by(id: params[:id])
    @work_space_amenity_category.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                                           status: :unprocessable_entity
  end
end
