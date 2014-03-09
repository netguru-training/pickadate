class EventsController < ApplicationController

  expose(:all_events) { Event.all.decorate }
  expose(:event, attributes: :permitted_params)
  expose_decorated(:duration) { event.duration || Duration.new }

  def create
    if event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    if event.save
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    event.destroy
    redirect_to events_path
  end

  def show
  end

  def add_user_to_event

    render nothing: true
  end

  private

  def permitted_params
    params.require(:event).permit(:name, duration: [:start_date, :end_date])
  end

end
