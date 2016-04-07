class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(show_params)
  end

  def new; end

  def create
    event = Event.create(create_params)
    redirect_to edit_event_path(event)
  end

  def edit
    @event = Event.find_by(edit_params)
  end

  def update
    @event = Event.find_by(show_params)
    @event.update(update_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find_by(delete_params)
    @event.destroy
    redirect_to events_path
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
