class Api::V1::BusinessUsersController < ApplicationController
  before_action :set_business_user, only: %i[show update destroy]

  def index
    @business_users = BusinessUser.for_business(params[:business_id]).order(:name)
    return unless stale?(@business_users)

    render json: { message: 'loaded business_user', data: @business_users }, status: :ok
  end

  def show
    render json: { message: 'loaded business_user', data: @business_users }, status: :ok
  end

  def create
    @business_user = BusinessUser.new(business_user_params)

    if @business_user.save
      render json: { message: 'business_user is saved', data: @business_user }, status: :ok
    else
      render json: { message: 'business_user is not saved', data: @business_user.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @business_user.update(business_user_params)
      render json: { message: 'business_user is updated', data: @business_user }, status: :ok
    else
      render json: { message: 'business_user is not updated', data: @business_user.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @business_user.destroy
      render json: { message: 'business_user successfully deleted', data: @business_user }, status: :ok
    else
      render json: { message: 'business_user is not deleted', data: @business_user.errors },
             status: :unprocessable_entity
    end
  end

  private

  def business_user_params
    params.permit(
			:first_name,
			:last_name,
			:admin,
			:business_id
		)
  end

  def set_business_user
    @business_user = BusinessUser.find_by(id: params[:id])
    @business_user.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                             status: :unprocessable_entity
  end
end
