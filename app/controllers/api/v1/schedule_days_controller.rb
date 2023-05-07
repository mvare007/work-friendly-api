class Api::V1::ScheduleDaysController < ApplicationController
  before_action :set_schedule_day, only: %i[show update destroy]

  def index
    @schedule_days = ScheduleDay.for_business(params[:business_id]).order(:weekday)

    render json: { message: 'loaded schedule_day', data: @schedule_days }, status: :ok
  end

  def show
    render json: { message: 'loaded schedule_day', data: @schedule_days }, status: :ok
  end

  def create
    @schedule_day = ScheduleDay.new(schedule_day_params)

    if @schedule_day.save
      render json: { message: 'schedule_day is saved', data: @schedule_day }, status: :ok
    else
      render json: { message: 'schedule_day is not saved', data: @schedule_day.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @schedule_day.update(schedule_day_params)
      render json: { message: 'schedule_day is updated', data: @schedule_day }, status: :ok
    else
      render json: { message: 'schedule_day is not updated', data: @schedule_day.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @schedule_day.destroy
      render json: { message: 'schedule_day successfully deleted', data: @schedule_day }, status: :ok
    else
      render json: { message: 'schedule_day is not deleted', data: @schedule_day.errors },
             status: :unprocessable_entity
    end
  end

  private

  def schedule_day_params
    params.permit(
      :weekday,
      :open_time,
      :close_time,
      :holiday,
      :holiday_name,
      :business_id
    )
  end

  def set_schedule_day
    @schedule_day = ScheduleDay.find_by(id: params[:id])
    @schedule_day.present? or return render json: { errors: t('errors.messages.item_not_found') },
                                            status: :unprocessable_entity
  end
end
