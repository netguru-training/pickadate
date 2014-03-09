class UsersEventsController < ApplicationController

  expose(:users_event)

  def create
    users_event = UsersEvent.new(user: current_user, event_id: params[:event_id])
    users_event.availability = params[:users_event][:avaibility].split(',').map(&:to_i)

    if users_event.save
      redirect_to events_path
    else
      redirect_to events_path(params[:event_id])
    end
  end

  def update
  end
end