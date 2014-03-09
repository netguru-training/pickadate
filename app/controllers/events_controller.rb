class EventsController < ApplicationController

  expose(:all_events) { Event.all.decorate }
  expose(:event, attributes: :permitted_params)
  expose_decorated(:duration) { event.duration || Duration.new }

  def create
    if event.save
      event.update_attributes(creator: current_user)
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

  private

  def permitted_params
    params.require(:event).permit(:name, :invite_only, duration: [:start_date, :end_date])
  end

end
