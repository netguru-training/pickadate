class EventsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:show]
  before_filter :ensure_that_user_is_creator, only: [:edit, :update]
  before_filter :ensure_that_user_can_see_event, only: [:show]

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
    if event.has_user?(current_user)
      @users_event = event.users_events.find_by(user_id: current_user.id)
    end
  end

  def add_user_to_event
    render nothing: true
  end

  private

  def ensure_that_user_is_creator
    redirect_to events_path unless event.is_created_by?(current_user)
  end

  def ensure_that_user_can_see_event
    redirect_to events_path if params[:token] != event.token and !event.is_visible_for_user?(current_user)
  end


  def permitted_params
    params.require(:event).permit(:name, :invite_only, guest_ids: [], duration: [:start_date, :end_date])
  end

end
