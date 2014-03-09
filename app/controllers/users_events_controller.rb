class UsersEventsController < ApplicationController

  expose(:users_event)

  def create
    users_event = UsersEvent.new(user: current_user, event_id: params[:event_id])
    users_event.availability = params[:users_event][:avaibility].split(',').map(&:to_i)

    redirect_to event_path(params[:event_id])
  end

end
