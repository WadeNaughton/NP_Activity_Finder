require 'rails_helper'

RSpec.describe MapService do
    it "returns a list of businesses", :vcr do
        location = "-77.6445079,39.3341151"
        q = "bar"
        circle = "-77.6445079,39.3341151,100000"
        sort = "distance"
        response = MapService.get_service(location, q, circle, sort)

        expect(response).to be_a Hash
    end
end