class ParksController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    @parks = NationalParkFacade.get_parks_by_state(params[:state])
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if NewPark.where(id: params[:id]).empty?
      @park = NationalParkFacade.one_park(params[:park_code])


      n = NewPark.new(address: @park.address, closed_day: @park.closed_day, description: @park.description,
                                 directions_website: @park.directions_website, email: @park.email, entrance_fees: @park.entrance_fees,
                                 latitude: @park.latitude, longitude: @park.longitude, name: @park.name,
                                 operating_hours: @park.operating_hours, park_code: @park.park_code, phone_number: @park.phone_number, photos: @park.photos)
       
        n.save
        @park = NewPark.find_by(id: n.id)
    else
     
      @park = NewPark.find(params[:id])
    end

     

  end

  private

  def park_params
    params.permit(:name, :description, :park_code, :latitude, :longitude, :phone_number, :email, :entrance_fees,
                  :directions_website, :closed_day, :operating_hours, :address, :photos)
  end
end
