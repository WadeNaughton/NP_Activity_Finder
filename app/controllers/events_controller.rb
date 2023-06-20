class EventsController < ApplicationController
  def index

    @events = NationalParkFacade.all_park_events(params[:park_id], params[:start], params[:finish])
    @park = NewPark.find_by(park_code: params[:park_id])
    @user = User.find(session[:user_id])

    if @events.empty?
      flash.now[:notice] = "No events available for this park."
    end

    #we have array of all events. we need to save a single event to the database
    #if the event is not already in the database
    #we create the event without the specific events information


  end

  def show
    @user = User.find(session[:user_id])
    @park = NewPark.find_by(id: params[:park_id])
    if NewEvent.where(id: params[:id]).empty?
      event = NationalParkFacade.get_single_event(params[:event_code])
      e = NewEvent.new(location: event.location, description: event.description, name: event.name, date: event.date, time: event.time, event_code: event.event_code, free: event.free, fee_info: event.fee_info, latitude: event.latitude, longitude: event.longitude, type_of_event: event.type_of_event)
      e.save
      @event = NewEvent.find_by(id: e.id)

    else
      @event = NewEvent.find(params[:id])
    end
  end
private
  def event_params
    params.require(:new_event).permit(:location, :description, :name, :date, :time, :event_code, :free, :id, :fee_info, :latitude, :longitude, :type_of_event)
  end 
end