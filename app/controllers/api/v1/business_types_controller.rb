class Api::V1::BusinessTypesController < ApplicationController
  before_action :set_business_type, only: %i[show update destroy]

  # @route GET /api/v1/business_types(/page/:page/per_page/:per_page) {format: :json} (api_v1_business_types)
  # @route GET /api/v1/business_types {format: :json}
  def index
    @business_types = BusinessType.order(:name)
                                  .page(params[:page])
                                  .per(params[:per_page])
    return unless stale?(@business_types)

    render json: BusinessTypeBlueprint.render(@business_types, root: :business_types), status: :ok
  end

  # @route GET /api/v1/business_types/:id {format: :json} (api_v1_business_type)
  def show
    render json: BusinessTypeBlueprint.render(@business_type), status: :ok
  end

  # @route POST /api/v1/business_types {format: :json}
  def create
    @business_type = BusinessType.new(business_type_params)

    if @business_type.save
      render json: BusinessTypeBlueprint.render(@business_type), status: :ok
    else
      render json: { business_type: BusinessTypeBlueprint.render(@business_type), errors: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/business_types/:id {format: :json} (api_v1_business_type)
  # @route PUT /api/v1/business_types/:id {format: :json} (api_v1_business_type)
  def update
    if @business_type.update(business_type_params)
      render json: BusinessTypeBlueprint.render(@business_type), status: :ok
    else
      render json: { business_type: BusinessTypeBlueprint.render(@business_type), errors: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/business_types/:id {format: :json} (api_v1_business_type)
  def destroy
    if @business_type.destroy
      render json: BusinessTypeBlueprint.render(@business_type), status: :ok
    else
      render json: { business_type: BusinessTypeBlueprint.render(@business_type), errors: @business_type.errors },
             status: :unprocessable_entity
    end
  end

  private

  def business_type_params
    params.permit(:name)
  end

  def set_business_type
    @business_type = BusinessType.find_by(id: params[:id])
    @business_type.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                             status: :unprocessable_entity
  end
end
