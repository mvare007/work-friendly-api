class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.order(:name)
                 .page(params[:page])
                 .per(params[:per_page])
    return unless stale?(@users)

    render json: UserBlueprint.render(@users, root: :users), status: :ok
  end

  def show
    render json: UserBlueprint.render(@user), status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserBlueprint.render(@user), status: :ok
    else
      render json: { user: UserBlueprint.render(@user), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserBlueprint.render(@user), status: :ok
    else
      render json: { user: UserBlueprint.render(@user), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { user: UserBlueprint.render(@user), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(
      :address,
      :email,
      :first_name,
      :last_name,
      :password_digest,
      :payment_info,
      :phone_number,
      :zip_code,
      :city_id
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
    @user.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                    status: :unprocessable_entity
  end
end
