class Api::V1::WorkSpacesController < ApplicationController
  before_action :set_work_space, only: %i[show update destroy]

  def index
    @work_spaces = WorkSpace.order(:name)
    @work_spaces = @work_spaces.for_business(params[:business_id]) if params[:business_id].present?
    @work_spaces = @work_spaces.page(params[:page]).per(params[:per_page])

    render json: WorkSpaceBlueprint.render(@work_spaces, root: :work_spaces), status: :ok
  end

  def show
    render json: WorkSpaceBlueprint.render(@work_space), status: :ok
  end

  def create
    @work_space = WorkSpace.new(work_space_params)

    if @work_space.save
      render json: WorkSpaceBlueprint.render(@work_space), status: :ok
    else
      render json: { work_space: WorkSpaceBlueprint.render(@work_space), errors: @work_space.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @work_space.update(work_space_params)
      render json: WorkSpaceBlueprint.render(@work_space), status: :ok
    else
      render json: { work_space: WorkSpaceBlueprint.render(@work_space), errors: @work_space.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @work_space.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { work_space: WorkSpaceBlueprint.render(@work_space), errors: @work_space.errors },
             status: :unprocessable_entity
    end
  end

  private

  def work_space_params
    params.permit(
      :available_from,
      :available_to,
      :capacity,
      :is_available,
      :name,
      :price_per_hour,
      :business_id
    )
  end

  def set_work_space
    @work_space = WorkSpace.find_by(id: params[:id])
    @work_space.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                          status: :unprocessable_entity
  end
end
