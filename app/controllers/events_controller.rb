class EventsController < ApplicationController

  expose(:event, attributes: :permitted_params)
  expose(:events)
  expose(:duration) { params[:id].present? ? event.duration : Duration.new }

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

  private

  def permitted_params
    params.require(:event).permit(:name, duration: [:start_date, :end_date])
  end

end
