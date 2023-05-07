class Api::V1::WorkSpacesController < ApplicationController
  before_action :set_work_space, only: %i[show update destroy]

  def index
    @work_spaces = WorkSpace.order(:name)
    render json: { message: 'loaded work_spaces', data: @work_spaces }, status: :ok
  end

  def show
    render json: { message: 'loaded work_space', data: @work_space }, status: :ok
  end

  def create
    @work_space = WorkSpace.new(work_space_params)

    if @work_space.save
      render json: { message: 'work_space is saved', data: @work_space }, status: :ok
    else
      render json: { message: 'work_space is not saved', data: @work_space.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @work_space.update(work_space_params)
      render json: { message: 'work_space is updated', data: @work_space }, status: :ok
    else
      render json: { message: 'work_space is not updated', data: @work_space.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @work_space.destroy
      render json: { message: 'work_space successfully deleted', data: @work_space }, status: :ok
    else
      render json: { message: 'work_space is not deleted', data: @work_space.errors },
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
