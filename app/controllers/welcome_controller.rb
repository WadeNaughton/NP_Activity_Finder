class WelcomeController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @user = User.find_by(id: session[:user_id])
    # @amenities = NationalParkFacade.get_amenities
  end
end
