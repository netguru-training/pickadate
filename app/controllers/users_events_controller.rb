class UsersEventsController < ApplicationController

  expose(:users_event)

  def create
    users_event = UsersEvent.new(user: current_user, event_id: params[:event_id])
    assign_avaibility
    save_users_event

    redirect_to event_path(params[:event_id])
  end

  def update
    assign_avaibility
    save_users_event

    redirect_to event_path(params[:event_id])
  end

  def save_users_event
    if users_event.save
      flash[:success] = "Succesfully updated !"
    else
      flash[:danger] = "Update failed !"
    end
  end

  private

  def assign_avaibility
    users_event.availability = params[:users_event][:avaibility].split(',').map(&:to_i)
  end
end
