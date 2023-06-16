class Park
  attr_reader :name, :description, :park_code, :latitude, :longitude, :phone_number, :email, :entrance_fees,
              :directions_website, :closed_day, :operating_hours, :address, :photos

  def initialize(data)
    @name = data[:fullName]
    @description = data[:description]
    @park_code = data[:parkCode]
    @latitude = data[:latitude]
    @longitude = data[:longitude]
    @phone_number = formatted_phone_number(data[:contacts][:phoneNumbers])
    @email = data[:contacts][:emailAddresses].first[:emailAddress]
    # @entrance_fees = data[:entranceFees] # iterate through
    @entrance_fees = formated_entrace_fees(data[:entranceFees])
    @directions_website = data[:directionsUrl]
    @closed_day = data[:operatingHours].first[:description]
    @operating_hours = formatted_operating_hours(data[:operatingHours].first[:standardHours]) # iterate through
    @address = formatted_address(data)
    @photos = formatted_photos(data[:images]) # iterate through
    # binding.pry
  end

  def formatted_phone_number(number)
    return nil if number.empty?

    number.first[:phoneNumber]
  end

  def formatted_address(data)
    "#{data[:addresses].first[:line1]}, #{data[:addresses].first[:city]}, #{data[:addresses].first[:stateCode]} #{data[:addresses].first[:postalCode]}"
  end

  def formatted_operating_hours(data)
    days = [['Monday'], ['Tuesday'], ['Wednesday'], ['Thursday'], ['Friday'], ['Saturday'], ['Sunday']]

    days.each do |day|
      data.each do |k, v|
        if day[0].downcase == k.to_s
          day << v
        end
      end
    end
    days
  end

  def formatted_photos(data)
    array = []
    data.each do |d|
      array << [d[:url], d[:altText]]
    end
    array
  end

  def formated_entrace_fees(data)
    array = []
    data.each do |d|
      array << [d[:cost], d[:description]]
    end
    array
    
  end
end
