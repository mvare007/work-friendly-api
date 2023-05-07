class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update destroy]

  def index
    @bookings = Booking.order(:created_at)
		@bookings = @bookings.for_business(params[:business_id]) if params[:business_id].present?
		@bookings = @bookings.for_user(params[:user_id]) if params[:user_id].present?
		@bookings = @bookings.page(params[:page]).per(params[:per_page])
		return unless stale?(@bookings)

    render json: { message: 'loaded bookings', data: @bookings }, status: :ok
  end

  def show
    render json: { message: 'loaded booking', data: @bookings }, status: :ok
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render json: { message: 'booking is saved', data: @booking }, status: :ok
    else
      render json: { message: 'booking is not saved', data: @booking.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      render json: { message: 'booking is updated', data: @booking }, status: :ok
    else
      render json: { message: 'booking is not updated', data: @booking.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.destroy
      render json: { message: 'booking successfully deleted', data: @booking }, status: :ok
    else
      render json: { message: 'booking is not deleted', data: @booking.errors },
             status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(
			:start_time,
			:end_time,
			:user_id,
			:work_space_id
		)
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])
    @booking.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                             status: :unprocessable_entity
  end
end