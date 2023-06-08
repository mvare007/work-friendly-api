class Api::V1::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create]
  before_action :set_user, only: %i[show update destroy]

  # @route GET /api/v1/users(/page/:page/per_page/:per_page) {format: :json} (api_v1_users)
  # @route GET /api/v1/users {format: :json} (api_v1_user_registration)
  def index
    @users = User.order(:first_name)
                 .page(params[:page])
                 .per(params[:per_page])
    return unless stale?(@users)

    render json: UserBlueprint.render(@users, root: :users), status: :ok
  end

  # @route GET /api/v1/users/:id {format: :json} (api_v1_user)
  def show
    render json: UserBlueprint.render(@user), status: :ok
  end

  # @route POST /api/v1/users {format: :json} (api_v1_user_registration)
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

  # @route PATCH /api/v1/users/:id {format: :json} (api_v1_user)
  # @route PUT /api/v1/users/:id {format: :json} (api_v1_user)
  def update
    if @user.update(user_params)
      render json: UserBlueprint.render(@user), status: :ok
    else
      render json: { user: UserBlueprint.render(@user), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/users/:id {format: :json} (api_v1_user)
  def destroy
    if @user.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { user: UserBlueprint.render(@user), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  # @route GET /api/v1/users/datatable {format: :json} (datatable_api_v1_users)
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
