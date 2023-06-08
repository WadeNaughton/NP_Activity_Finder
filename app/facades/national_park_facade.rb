class NationalParkFacade

    def self.get_parks_by_state(state)
        search = NationalParkService.parks_by_state(state)
        parks = search[:data]
        parks.map do |park|
            Park.new(park)
        end
    end
end