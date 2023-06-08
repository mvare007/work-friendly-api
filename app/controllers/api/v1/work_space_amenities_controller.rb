class Api::V1::WorkSpaceAmenitiesController < ApplicationController
  before_action :set_work_space_amenity, only: %i[show update destroy]

  # @route GET /api/v1/work_space_amenities(/page/:page/per_page/:per_page) {format: :json} (api_v1_work_space_amenities)
  # @route GET /api/v1/work_space_amenities {format: :json}
  def index
    @work_space_amenities = WorkSpaceAmenity.order(:name)
                                            .page(params[:page])
                                            .per(params[:per_page])
    render json: WorkSpaceAmenityBlueprint.render(@work_space_amenities, root: :work_space_amenities), status: :ok
  end

  # @route GET /api/v1/work_space_amenities/:id {format: :json} (api_v1_work_space_amenity)
  def show
    render json: WorkSpaceAmenityBlueprint.render(@work_space_amenity), status: :ok
  end

  # @route POST /api/v1/work_space_amenities {format: :json}
  def create
    @work_space_amenity = WorkSpaceAmenity.new(work_space_amenity_params)
    if @work_space_amenity.save
      render json: WorkSpaceAmenityBlueprint.render(@work_space_amenity), status: :ok
    else
      render json: { work_space_amenity: WorkSpaceAmenityBlueprint.render(@work_space_amenity),
                     errors: @work_space_amenity.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/work_space_amenities/:id {format: :json} (api_v1_work_space_amenity)
  # @route PUT /api/v1/work_space_amenities/:id {format: :json} (api_v1_work_space_amenity)
  def update
    if @work_space_amenity.update(work_space_amenity_params)
      render json: WorkSpaceAmenityBlueprint.render(@work_space_amenity), status: :ok
    else
      render json: { work_space_amenity: WorkSpaceAmenityBlueprint.render(@work_space_amenity),
                     errors: @work_space_amenity.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/work_space_amenities/:id {format: :json} (api_v1_work_space_amenity)
  def destroy
    if @work_space_amenity.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { work_space_amenity: WorkSpaceAmenityBlueprint.render(@work_space_amenity),
                     errors: @work_space_amenity.errors },
             status: :unprocessable_entity
    end
  end

  private

  def work_space_amenity_params
    params.permit(:name, :description, :work_space_amenity_category_id)
  end

  def set_work_space_amenity
    @work_space_amenity = WorkSpaceAmenity.find_by(id: params[:id])
    @work_space_amenity.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                                  status: :unprocessable_entity
  end
end
