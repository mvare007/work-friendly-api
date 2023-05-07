class Api::V1::ReviewsController < ApplicationController
  before_action :set_review, only: %i[show update destroy]

  def index
    @reviews = Review.order(:created_at)
    @reviews = @reviews.for_business(params[:business_id]) if params[:business_id].present?
    @reviews = @reviews.for_user(params[:user_id]) if params[:user_id].present?
    @reviews = @reviews.page(params[:page]).per(params[:per_page])
    return unless stale?(@reviews)

    render json: { message: 'loaded review', data: @reviews }, status: :ok
  end

  def show
    render json: { message: 'loaded review', data: @reviews }, status: :ok
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: { message: 'review is saved', data: @review }, status: :ok
    else
      render json: { message: 'review is not saved', data: @review.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: { message: 'review is updated', data: @review }, status: :ok
    else
      render json: { message: 'review is not updated', data: @review.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @review.destroy
      render json: { message: 'review successfully deleted', data: @review }, status: :ok
    else
      render json: { message: 'review is not deleted', data: @review.errors },
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
