class Api::V1::WorkSpaceAmenityCategoriesController < ApplicationController
  before_action :set_work_space_amenity_category, only: %i[show update destroy]

  def index
    @work_space_amenity_categories = WorkSpaceAmenityCategory.order(:name)

    render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_categories, root: :work_space_amenity_categories), status: :ok
  end

  def show
    render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category), status: :ok
  end

  def create
    @work_space_amenity_category = WorkSpaceAmenityCategory.new(work_space_amenity_category_params)
    if @work_space_amenity_category.save
      render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category), status: :ok
    else
      render json: { work_space_amenity_category: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category),
                     errors: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @work_space_amenity_category.update(work_space_amenity_category_params)
      render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category), status: :ok
    else
      render json: { work_space_amenity_category: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category),
                     errors: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @work_space_amenity_category.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { work_space_amenity_category: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category),
                     errors: @work_space_amenity_category.errors },
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
