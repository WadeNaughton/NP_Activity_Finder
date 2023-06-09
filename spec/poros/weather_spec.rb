require 'rails_helper'

RSpec.describe 'Weather Poro' do
  it 'tests weather attributes' do
    data = { dt: 1_614_686_400,
             sunrise: 1_614_668_500,
             sunset: 1_614_709_920,
             moonrise: 1_614_667_560,
             moonset: 1_614_706_800,
             moon_phase: 0.98,
             temp: { day: 45.66, min: 30.69, max: 45.66, night: 30.69, eve: 38.14, morn: 45.66 },
             feels_like: { day: 37.06, night: 22.66, eve: 30.29, morn: 37.06 },
             pressure: 1019,
             humidity: 25,
             dew_point: 10.49,
             wind_speed: 4.21,
             wind_deg: 217,
             wind_gust: 6.87,
             weather: [{ id: 800, main: 'Clear', description: 'clear sky', icon: '01d' }],
             clouds: 0,
             pop: 0,
             uvi: 4.01 }

    weather = Weather.new(data)
    expect(weather).to be_a Weather
  end
end
