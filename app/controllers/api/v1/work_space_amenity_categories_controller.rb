class Api::V1::WorkSpaceAmenityCategoriesController < ApplicationController
  before_action :set_work_space_amenity_category, only: %i[show update destroy]

  # @route GET /api/v1/work_space_amenity_categories {format: :json} (api_v1_work_space_amenity_categories)
  def index
    @work_space_amenity_categories = WorkSpaceAmenityCategory.order(:name)

    render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_categories, root: :work_space_amenity_categories), status: :ok
  end

  # @route GET /api/v1/work_space_amenity_categories/:id {format: :json} (api_v1_work_space_amenity_category)
  def show
    render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category), status: :ok
  end

  # @route POST /api/v1/work_space_amenity_categories {format: :json} (api_v1_work_space_amenity_categories)
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

  # @route PATCH /api/v1/work_space_amenity_categories/:id {format: :json} (api_v1_work_space_amenity_category)
  # @route PUT /api/v1/work_space_amenity_categories/:id {format: :json} (api_v1_work_space_amenity_category)
  def update
    if @work_space_amenity_category.update(work_space_amenity_category_params)
      render json: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category), status: :ok
    else
      render json: { work_space_amenity_category: WorkSpaceAmenityCategoryBlueprint.render(@work_space_amenity_category),
                     errors: @work_space_amenity_category.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/work_space_amenity_categories/:id {format: :json} (api_v1_work_space_amenity_category)
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
