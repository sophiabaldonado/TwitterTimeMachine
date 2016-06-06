require 'httparty'

class DaylightWrapper

  attr_reader :sunrise, :sunset

  def initialize(daylight_object)
    @sunrise = daylight_object["results"]["sunrise"]
    @sunset = daylight_object["results"]["sunset"]
  end

  def self.get_daylight(coords)
    daylight = HTTParty.get("http://api.sunrise-sunset.org/json?lat=#{coords[0]}&lng=#{coords[1]}&date=today").parsed_response
    self.new(daylight)
  end

end
