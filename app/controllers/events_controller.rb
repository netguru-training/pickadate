class EventsController < ApplicationController

  expose(:event)
  expose(:events)

  def index
  end

  def create
    if event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def destroy
    event.destroy
    redirect_to events_path
  end

end
