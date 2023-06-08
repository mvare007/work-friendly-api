class Api::V1::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create]
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.order(:first_name)
                 .page(params[:page])
                 .per(params[:per_page])
    return unless stale?(@users)

    render json: UserBlueprint.render(@users, root: :users), status: :ok
  end

  def show
    render json: UserBlueprint.render(@user), status: :ok
  end

  def create
    user = User.new(user_params)
    client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
    return render json: { errors: 'Invalid client ID' }, status: :forbidden unless client_app

    if user.save
      access_token = DoorkeeperService::AccessTokenCreator.call(user, client_app)

      render json: {
        user: {
          id: user.id,
          email: user.email,
          access_token: access_token.token,
          token_type: 'bearer',
          expires_in: access_token.expires_in,
          refresh_token: access_token.refresh_token,
          created_at: access_token.created_at.to_time.to_i
        }
      }
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
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

  def datatable
    render json: UserDatatable.new(User.all)
  end

  private

  def user_params
    params.permit(
      :address,
      :email,
      :first_name,
      :last_name,
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
