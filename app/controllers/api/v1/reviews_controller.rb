class Api::V1::ReviewsController < ApplicationController
  before_action :set_review, only: %i[show update destroy]

  # @route GET /api/v1/reviews(/page/:page/per_page/:per_page) {format: :json} (api_v1_reviews)
  # @route GET /api/v1/reviews {format: :json}
  def index
    @reviews = Review.order(:created_at)
    @reviews = @reviews.for_business(params[:business_id]) if params[:business_id].present?
    @reviews = @reviews.for_user(params[:user_id]) if params[:user_id].present?
    @reviews = @reviews.page(params[:page]).per(params[:per_page])
    return unless stale?(@reviews)

    render json: ReviewBlueprint.render(@reviews, root: :reviews), status: :ok
  end

  # @route GET /api/v1/reviews/:id {format: :json} (api_v1_review)
  def show
    render json: ReviewBlueprint.render(@review), status: :ok
  end

  # @route POST /api/v1/reviews {format: :json}
  def create
    @review = Review.new(review_params)

    if @review.save
      render json: ReviewBlueprint.render(@review), status: :ok
    else
      render json: { review: ReviewBlueprint.render(@review), errors: @review.errors },
             status: :unprocessable_entity
    end
  end

  # @route PATCH /api/v1/reviews/:id {format: :json} (api_v1_review)
  # @route PUT /api/v1/reviews/:id {format: :json} (api_v1_review)
  def update
    if @review.update(review_params)
      render json: ReviewBlueprint.render(@review), status: :ok
    else
      render json: { review: ReviewBlueprint.render(@review), errors: @review.errors },
             status: :unprocessable_entity
    end
  end

  # @route DELETE /api/v1/reviews/:id {format: :json} (api_v1_review)
  def destroy
    if @review.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { review: ReviewBlueprint.render(@review), errors: @review.errors },
             status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.permit(
      :rating,
      :comment,
      :user_id,
      :business_id
    )
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    @review.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                      status: :unprocessable_entity
  end
end
