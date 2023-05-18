class WorkSpaceAmenitesController < ApplicationController
  before_action :set_work_space_amenity, only: %i[show update destroy]

  def index
    @work_space_amenities = WorkSpaceAmenity.order(:name)
                                            .page(params[:page])
                                            .per(params[:per_page])
    render json: { message: 'loaded work_space_amenities', data: @work_space_amenities }, status: :ok
  end

  def show
    render json: { message: 'loaded work_space_amenity', data: @work_space_amenity }, status: :ok
  end

  def create
    @work_space_amenity = WorkSpaceAmenity.new(work_space_amenity_params)
    if @work_space_amenity.save
      render json: { message: 'work_space_amenity is saved', data: @work_space_amenity }, status: :ok
    else
      render json: { message: 'work_space_amenity is not saved', data: @work_space_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @work_space_amenity.update(work_space_amenity_params)
      render json: { message: 'work_space_amenity is updated', data: @work_space_amenity },
             status: :ok
    else
      render json: { message: 'work_space_amenity is not updated', data: @work_space_amenity.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @work_space_amenity.destroy
      render json: { message: 'work_space_amenity successfully deleted', data: @work_space_amenity },
             status: :ok
    else
      render json: { message: 'work_space_amenity is not deleted', data: @work_space_amenity.errors },
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
