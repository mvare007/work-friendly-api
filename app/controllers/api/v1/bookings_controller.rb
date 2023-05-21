class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update destroy]

  def index
    @bookings = Booking.order(:created_at)
    @bookings = @bookings.for_business(params[:business_id]) if params[:business_id].present?
    @bookings = @bookings.for_user(params[:user_id]) if params[:user_id].present?
    @bookings = @bookings.page(params[:page]).per(params[:per_page])
    return unless stale?(@bookings)

    render json: BookingBlueprint.render(@bookings, root: :bookings), status: :ok
  end

  def show
    render json: BookingBlueprint.render(@booking, view: :extended), status: :ok
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render json: BookingBlueprint.render(@booking), status: :ok
    else
      render json: { booking: BookingBlueprint.render(@booking), errors: @booking.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_update_params)
      render json: BookingBlueprint.render(@booking), status: :ok
    else
      render json: { booking: BookingBlueprint.render(@booking), errors: @booking.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.destroy
      render json: { message: 'deleted successfully' }, status: :ok
    else
      render json: { booking: BookingBlueprint.render(@booking), errors: @booking.errors },
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

  def booking_update_params
    params.permit(:status, :start_time, :end_time)
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])
    @booking.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                       status: :unprocessable_entity
  end
end
