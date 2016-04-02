class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all
  end

  def show
    @calendar = Calendar.find_by(show_params)
  end

  def new

  end

  def create
    calendar = Calendar.create(create_params)
    redirect_to edit_calendar_path(calendar)
  end

  def edit
    @calendar = Calendar.find_by(edit_params)
  end

  def update
    @calendar = Calendar.find_by(show_params)
    @calendar.update(update_params)
    redirect_to calendar_path(@calendar)
  end

  def destroy
    @calendar = Calendar.find_by(delete_params)
    @calendar.destroy
    redirect_to calendars_path
  end

  private

  def create_params
    params.permit(:name)
  end

  def edit_params
    params.permit(:id)
  end

  def show_params
    params.permit(:id)
  end

  def update_params
    params.permit(:id, :name, :archived)
  end

  def delete_params
    params.permit(:id)
  end
end
