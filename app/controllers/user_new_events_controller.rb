class UserNewEventsController < ApplicationController
  def create

    @user = User.find(params[:user_id])

    if NewEvent.where(id: params[:id]).empty?
      event = NationalParkFacade.get_single_event(params[:event_id])
      e = NewEvent.new(location: event.location, description: event.description, name: event.name,
                       date: event.date, time: event.time, event_code: event.event_code, free: event.free, fee_info: event.fee_info, latitude: event.latitude, longitude: event.longitude, type_of_event: event.type_of_event)
      e.save
      @new_event = UserNewEvent.create!(user_id: @user.id, new_event_id: e.id, new_park_id: params[:park_id])

    else
      @event = NewEvent.find_by(id: params[:id])
      @new_event = UserNewEvent.find_by(user_id: @user.id, new_event_id: @event.id, new_park_id: params[:park_id])

    end
    redirect_to user_path(@user)
  end

  def update
    @user = User.find(params[:user_id])
    @new_event = UserNewEvent.find_by(user_id: @user.id, new_event_id: params[:id], new_park_id: params[:park_id])
    @new_event.update(new_event_params)

    redirect_to user_path(@user)
  end

  def destroy

    @user = User.find(params[:user_id])
    @new_event = UserNewEvent.find_by(user_id: @user.id, new_event_id: params[:event_id], new_park_id: params[:park_id])
    # binding.pry 
    @new_event.delete
    redirect_to user_path(@user)
    
  end

  private

  def new_event_params
    params.permit(:new_event_id, :user_id, :new_park_id, :date_attend)
  end
end
