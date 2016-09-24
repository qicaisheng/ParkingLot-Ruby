require 'parking_boy'

class  Manager < ParkingBoy
  def initialize(resource)
    @parking_lots = resource[:parking_lots]
    @parking_boys = resource[:parking_boys]
  end

  def park_by(parking_boy, car)
    return false unless @parking_boys.include? parking_boy
    parking_boy.park(car)
  end
end
